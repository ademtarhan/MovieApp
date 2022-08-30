//
//  FavoriteViewController.swift
//  MovieApp
//
//  Created by Adem Tarhan on 27.08.2022.
//

import UIKit


protocol FavoriteViewController: AnyObject{
    var favoriteMovies : [MovieResult] {get set}
}


class FavoriteViewControllerImpl: UIViewController {
    
    var favoriteMovies = [MovieResult]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
