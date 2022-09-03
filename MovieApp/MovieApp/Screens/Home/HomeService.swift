//
//  HomeService.swift
//  MovieApp
//
//  Created by Adem Tarhan on 16.08.2022.
//

import FirebaseAuth
import FirebaseCrashlytics
import Foundation

protocol HomeService: AnyObject {
    func getMovies(at page: Int, _ completion: @escaping (Result<[MovieResult], Error>) -> Void)
}

class HomeServiceImpl: HomeService, APICallable {
    func getMovies(at page: Int, _ completion: @escaping (Result<[MovieResult], Error>) -> Void) {
        let endPoint = "\(BaseURL)list/\(page)?api_key=\(APIKey)"

        guard let safeURLString = endPoint.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let endpointURL = URL(string: safeURLString) else {
            fatalError("invalid URL")
            dlog(self, "invalid URL error")
            completion(.failure(MovieError.invalidURL(endPoint)))
            return
        }
        

        URLSession.shared.dataTask(with: endpointURL) { data, _, error in
            guard error == nil else {
                fatalError("\(error)")
                dlog(self, "data error")
                completion(.failure(MovieError.forwarded(error!)))

                return
            }

            guard data != nil else {
                fatalError("endpointURL error")
                dlog(self, "endpointURL error")
                completion(.failure(MovieError.invalidPayload(endpointURL)))
                return
            }
            do {
                let movieResponse = try JSONDecoder().decode(Movie.self, from: data!)
                let results = movieResponse.results

                completion(.success(results))
            } catch {
                fatalError("forwarded error")
                dlog(self, "forwarded error")
                completion(.failure(MovieError.forwarded(error)))
            }
        }.resume()
    }
}
