//
//  LogInEntity.swift
//  MovieApp
//
//  Created by Adem Tarhan on 16.08.2022.
//

import FirebaseAuth
import Foundation

struct LogInEntity {
    struct User {
        var email: String?
        var uid: String?
        init(user: FirebaseAuth.User?) {
            email = user?.email
            uid = user?.uid
        }
    }

    struct LogInError {
    }
}

enum LogInError: Error {
    case logInError
    case creatError
    case invalidPassword
    case invalidEmail
    case timeout
    case unKnownError
    case wrongPassword
}
