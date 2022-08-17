//
//  HomeViewController.swift
//  MovieApp
//
//  Created by Adem Tarhan on 16.08.2022.
//

import UIKit

protocol HomeViewController: AnyObject {
    var presenter: HomePresenter? { get set }
    func update(movies: [MovieResult])
    func showErrorAlert()
}

class HomeViewControllerImpl: UIViewController, HomeViewController, UICollectionViewDataSource {
    var movie: MovieResult?
    var movies = [MovieResult]()
    var presenter: HomePresenter?
    @IBOutlet var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        let nibCell = UINib(nibName: "CollectionViewCell", bundle: nil)
        collectionView.register(nibCell, forCellWithReuseIdentifier: "cell")
        presenter?.setData()
        
        navigationItem.title = "MOVIES"
        
        
        
        
    }

    func update(movies: [MovieResult]) {
        // self.movies.append(contentsOf: movies)

        DispatchQueue.main.async {
            self.movies = movies
            self.collectionView.reloadData()
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

extension HomeViewControllerImpl {
    func showErrorAlert() {
    }
}

extension HomeViewControllerImpl {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        let movie = movies[indexPath.row]
        cell.setup(movie)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
}

extension HomeViewControllerImpl: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width - 30) / 2, height: view.frame.height / 3)
    }
}

extension HomeViewControllerImpl: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == movies.count - 1 {
            presenter?.setData()
        }
    }
}
