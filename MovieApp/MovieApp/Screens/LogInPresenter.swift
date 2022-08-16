//
//  LogInPresenter.swift
//  MovieApp
//
//  Created by Adem Tarhan on 16.08.2022.
//

import Foundation

protocol LogInPresenter: AnyObject{
    var interactor: LogInInteractor? {get set}
    func createAccount(withEmail email: String?, password: String?) -> Void
    func logIn(with email: String,password: String) -> Void
}

class LogInPresenterImpl: LogInPresenter{
    var interactor: LogInInteractor?
    
    
    func logIn(with email: String,password: String) -> Void{
        interactor?.logIn(withEmail: email, password: password, { result in
            switch result{
            case .success:
                
                break
            case .failure:
                // TODO: show message
                break
            }
        })
    }
    
    func createAccount(withEmail email: String?, password: String?) -> Void{
        guard let email = email, let password = password else {
            // .. TODO: SHOW ERROR MESSAGE
            return
        }

        interactor?.createAccount(withEmail: email, password: password, { result in
            switch result{
            case .success:
                break
            case .failure:
                break
            }
        })
    }
    
}
