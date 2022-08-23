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

                let sortedArray = movies.sorted { $0.voteAverage > $1.voteAverage }
                self.view?.update(movies: sortedArray)

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
                print("page: \(page) movies: \(movies.count)")
                //  print("movies count: \(moviesArray.count)")
                // if moviesArray.count < 10 {

                for i in 0 ... movies.count - 1 {
                    //        print("i: \(i)")
                    moviesArray.append(movies[i])
//                    print("moviesArrayCount: \(moviesArray.count)")

                    let sortedArray = moviesArray.sorted { $0.voteAverage < $1.voteAverage }
                    // self.view?.update(movies: sortedArray)
                    // self.view?.didTapLowAverage()
                }

                print("moviesArrayCount: \(moviesArray.count)")

            case .failure:
                self.view?.showErrorAlert()
            }
        })
    }
}
