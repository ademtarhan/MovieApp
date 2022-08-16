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
        LogInViewController(nibName: "LogInViewController", bundle: nil)
    }
}
