//
//  LogInRouter.swift
//  MovieApp
//
//  Created by Adem Tarhan on 16.08.2022.
//

import Foundation


class LogInRouter{
    public static var shared = LogInRouter()
    var logIn : LogInViewController{
        let view = LogInViewControllerImpl(nibName: "LogInViewController", bundle: nil)
        let presenter : LogInPresenter = LogInPresenterImpl()
        let interactor : LogInInteractor = LogInInteractorImpl()
        //let router : LogInRouter = LogInRouter()
        let service : LogInService = LogInServiceImpl()
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        interactor.service = service
        return view
    }
}
