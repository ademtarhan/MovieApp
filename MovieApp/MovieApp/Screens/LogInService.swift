//
//  LogInService.swift
//  MovieApp
//
//  Created by Adem Tarhan on 16.08.2022.
//

import FirebaseAuth
import Foundation

protocol LogInService: AnyObject {
    func logIn(withEmail email: String, password: String, _ completionHandler: @escaping (Result<Any, LogInError>) -> Void)
    func createAccount(withEmail email: String, password: String, _ completionHandler: @escaping (Result<Any, LogInError>) -> Void)
}

class LogInServiceImpl: LogInService {
    
    
    func logIn(withEmail email: String, password: String, _ completionHandler: @escaping (Result<Any, LogInError>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { _, error in
            if let error = error {
                print("SigIn Error: \(error.localizedDescription)")
                completionHandler(.failure(self.getAuthError(errCode: error._code)))
            } else {
                print("Log In Success")
                completionHandler(.success(true))
            }
        }
    }

    func createAccount(withEmail email: String, password: String, _ completionHandler: @escaping (Result<Any, LogInError>) -> Void) {
        
        print("email\(email)-password\(password)")
        
        Auth.auth().createUser(withEmail: email, password: password) { _, error in

            if let error = error {
                completionHandler(.failure(self.getAuthError(errCode: error._code)))
            } else {
               // let user = LogInEntity.User(user: r?.user)
                print("created user")
                
                completionHandler(.success(true))
            }
        }
    }

    private func getAuthError(errCode: Int) -> LogInError {
        let error = AuthErrorCode.Code(rawValue: errCode)
        switch error {
        case .invalidEmail:
            return .invalidEmail
        case .wrongPassword:
            return .wrongPassword
        default:
            return .unKnownError
        }
    }
}
