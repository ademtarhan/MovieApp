//
//  LogInınteractor.swift
//  MovieApp
//
//  Created by Adem Tarhan on 16.08.2022.
//

import Foundation
import FirebaseAuth

protocol LogInInteractor: AnyObject {
    var service: LogInService? { get set }
    func logIn(withEmail email: String, password: String, _ completionHandler: @escaping (Result<Any, LogInError>) -> Void)
    func createAccount(withEmail email: String, password: String, _ completionHandler: @escaping (Result<Any, LogInError>) -> Void)
}

class LogInInteractorImpl: LogInInteractor {
    
    
    var service: LogInService?
    var user = LogInEntity.User.self

    func logIn(withEmail email: String, password: String, _ completionHandler: @escaping (Result<Any, LogInError>) -> Void) {
        service?.logIn(withEmail: email, password: password, { result in
            switch result {
            case .success:
                completionHandler(.success(true))
            case .failure:
                completionHandler(.failure(.logInError))
            }
        })
    }

    func createAccount(withEmail email: String, password: String, _ completionHandler: @escaping (Result<Any, LogInError>) -> Void) {
        service?.createAccount(withEmail: email, password: password, { result in
            switch result {
            case let .success:
                completionHandler(.success(true))
            case .failure:
                completionHandler(.failure(.creatError))
            }
        })
    }
}
