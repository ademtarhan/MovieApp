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
        HomeViewControllerImpl(nibName: "HomeViewController", bundle: nil)
    }
}
