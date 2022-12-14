//
//  HomeRouter.swift
//  MovieApp
//
//  Created by Adem Tarhan on 16.08.2022.
//

import Foundation


class HomeRouter{
    public static var shared = HomeRouter()
    
    var home : HomeViewController{
        let view = HomeViewControllerImpl(nibName: "HomeViewController", bundle: nil)
        let presenter : HomePresenter = HomePresenterImpl()
        let interactor : HomeInteractor = HomeInteractorImpl()
        let service : HomeService = HomeServiceImpl()
        let localStorageService : LocalStorageService = LocalStorageServiceImpl()
        
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.view = view
        interactor.service = service
        view.localStorageService = localStorageService
        localStorageService.view = view
        return view
    }
}
