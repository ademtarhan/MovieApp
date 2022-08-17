//
//  HomeService.swift
//  MovieApp
//
//  Created by Adem Tarhan on 16.08.2022.
//

import Foundation
import FirebaseAuth


protocol HomeService: AnyObject{
    func getMovies(at page: Int, _ completion: @escaping (Result<[MovieResult], Error>) -> Void)
}

class HomeServiceImpl: HomeService, APICallable{
    func getMovies(at page: Int, _ completion: @escaping (Result<[MovieResult], Error>) -> Void) {
        let endPoint = "\(BaseURL)list/\(page)?api_key=\(APIKey)"

        guard let safeURLString = endPoint.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let endpointURL = URL(string: safeURLString) else {
            print(MovieError.invalidURL(endPoint))
            completion(.failure(MovieError.invalidURL(endPoint)))
            return
        }

        URLSession.shared.dataTask(with: endpointURL) { data, _, error in
            guard error == nil else {
                print(MovieError.forwarded(error!))
                completion(.failure(MovieError.forwarded(error!)))

                return
            }

            guard data != nil else {
                print(MovieError.invalidPayload(endpointURL))
                completion(.failure(MovieError.invalidPayload(endpointURL)))
                return
            }
            do {
                let movieResponse = try JSONDecoder().decode(Movie.self, from: data!)
                let results = movieResponse.results

                completion(.success(results))
            } catch {
                print(MovieError.forwarded(error))
                completion(.failure(MovieError.forwarded(error)))
            }
        }.resume()
    }
}
