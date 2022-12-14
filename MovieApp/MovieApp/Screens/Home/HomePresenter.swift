//
//  HomePresenter.swift
//  MovieApp
//
//  Created by Adem Tarhan on 16.08.2022.
//

import Foundation

protocol HomePresenter: AnyObject {
    var interactor: HomeInteractor? { get set }
    var view: HomeViewController? { get set }
    func setData()
    func setDataForHighAverage()
    func setDataForLowAverage()
}

class HomePresenterImpl: HomePresenter {
    var interactor: HomeInteractor?
    var view: HomeViewController?
    private var page = 0
    var moviesArray = [MovieResult]()

    func setData() {
        page += 1
        interactor?.getMovies(at: page, { [self] result in
            switch result {
            case let .success(movies):
                if moviesArray.count < 49 {
                    movies.forEach { movie in
                        moviesArray.append(movie)
                    }
                }
                self.view?.update(movies: moviesArray)
            case .failure:
                self.view?.showErrorAlert()
            }
        })
    }

    func setDataForLowAverage() {
        page += 1
        interactor?.getMovies(at: page, { [self] result in
            switch result {
            case let .success(movies):
                if moviesArray.count < 49 {
                    movies.forEach { movie in
                        moviesArray.append(movie)
                    }
                }
                let sortedArray = moviesArray.sorted { $0.voteAverage < $1.voteAverage }
                self.view?.update(movies: sortedArray)
            case .failure:
                self.view?.showErrorAlert()
            }
        })
    }

    func setDataForHighAverage() {
        page += 1
        interactor?.getMovies(at: page, { [self] result in
            switch result {
            case let .success(movies):
                if moviesArray.count < 49 {
                    movies.forEach { movie in
                        moviesArray.append(movie)
                    }
                }
                let sortedArray = moviesArray.sorted { $0.voteAverage > $1.voteAverage }
                self.view?.update(movies: sortedArray)
            case .failure:
                self.view?.showErrorAlert()
            }
        })
    }
}
