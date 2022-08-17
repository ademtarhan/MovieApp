//
//  HomePresenter.swift
//  MovieApp
//
//  Created by Adem Tarhan on 16.08.2022.
//

import Foundation


protocol HomePresenter: AnyObject{
    var interactor: HomeInteractor? {get set}
    var view: HomeViewController? {get set}
}


class HomePresenterImpl: HomePresenter{
    var interactor: HomeInteractor?
    var view: HomeViewController?
    private var page = 0
    
    func setData(){
        page += 1
        interactor?.getMovies(at: page, { result in
            switch result{
            case let .success(movies):
                self.view?.update(movies: movies)
            case .failure:
                self.view?.showErrorAlert()
            }
        })
    }
    
}
