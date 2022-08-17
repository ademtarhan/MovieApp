//
//  HomeViewController.swift
//  MovieApp
//
//  Created by Adem Tarhan on 16.08.2022.
//

import UIKit

protocol HomeViewController: AnyObject{
    var presenter : HomePresenter? {get set}
    func update(movies: [MovieResult])
    func showErrorAlert()
}

class HomeViewControllerImpl: UIViewController, HomeViewController {
    var presenter: HomePresenter?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    func update(movies: [MovieResult]) {
        //self.movies.append(contentsOf: movies)
        
        DispatchQueue.main.async {
            //self.movies = movies
           // self.collectionView.reloadData()
        }
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


extension HomeViewControllerImpl{
    func showErrorAlert(){
        
    }
}
