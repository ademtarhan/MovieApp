//
//  FavoriteViewController.swift
//  MovieApp
//
//  Created by Adem Tarhan on 27.08.2022.
//

import UIKit


protocol FavoriteViewController: AnyObject{
    var detail : DetailsViewController? {get set}
    var favoriteMovies : [MovieResult] {get set}
}


class FavoriteViewControllerImpl: UIViewController, FavoriteViewController, UICollectionViewDataSource {
    var detail: DetailsViewController?
    
    @IBOutlet weak var collectionView: UICollectionView!
    var favoriteMovies = [MovieResult]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Favorite"
        detail = DetailsViewControllerImpl()
        favoriteMovies = detail!.favoriMovies
        dlog(self, "favorite : \(favoriteMovies)")
        
        
        
        
    }
    
    


}


extension FavoriteViewControllerImpl{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let itemNumber = NSNumber(value: indexPath.item)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        let movie = favoriteMovies[indexPath.row]

        cell.setup(itemNumber: itemNumber, movie)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteMovies.count
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detail = DetailsViewControllerImpl(nibName: "DetailsViewController", bundle: nil)
        let movie = favoriteMovies[indexPath.row]
        detail.movie = movie
        navigationController?.pushViewController(detail, animated: true)
    }
}

extension FavoriteViewControllerImpl: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width - 20) / 2, height: view.frame.height / 3)
    }
}

