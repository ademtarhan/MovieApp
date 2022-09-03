//
//  FavoriteRouter.swift
//  MovieApp
//
//  Created by Adem Tarhan on 31.08.2022.
//

import Foundation

class FavoriteRouter{
    
    var favorite : FavoriteViewController{
        let view = FavoriteViewControllerImpl(nibName: "FavoriteViewController", bundle: nil)
        let detail = DetailsViewControllerImpl()
        view.detail = detail
        return view
    }
}
