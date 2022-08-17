//
//  HomeInteractor.swift
//  MovieApp
//
//  Created by Adem Tarhan on 16.08.2022.
//

import Foundation

protocol HomeInteractor: AnyObject {
    var service: HomeService? { get set }
    func getMovies(at page: Int, _ completionHandler: @escaping (Result<[MovieResult], Error>) -> Void)
}

class HomeInteractorImpl: HomeInteractor {
    var service: HomeService?

    func getMovies(at page: Int, _ completionHandler: @escaping (Result<[MovieResult], Error>) -> Void) {
        service?.getMovies(at: page, { result in
            switch result {
            case let .success(movies):
                print("\(movies)")
                completionHandler(.success(movies))
            case let .failure(error):
                completionHandler(.failure(MovieError.forwarded(error)))
            }
        })
    }
}
