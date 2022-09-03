//
//  HomeViewController.swift
//  MovieApp
//
//  Created by Adem Tarhan on 16.08.2022.
//

import FirebaseCrashlytics
import UIKit

protocol HomeViewController: AnyObject {
    var presenter: HomePresenter? { get set }
    var movies: [MovieResult] { get }
    var detail: DetailsViewController? {get set}
    var localStorageService: LocalStorageService? { get set }
    func update(movies: [MovieResult])
    func showErrorAlert()
}

class HomeViewControllerImpl: UIViewController, HomeViewController, UICollectionViewDataSource {
    var movie: MovieResult?
    var movies = [MovieResult]()
    var presenter: HomePresenter?
    var detail: DetailsViewController?
    var localStorageService: LocalStorageService?

    @IBOutlet var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        let nibCell = UINib(nibName: "CollectionViewCell", bundle: nil)
        collectionView.register(nibCell, forCellWithReuseIdentifier: "cell")
        presenter?.setData()
        localStorageService?.fetch()

        navigationItem.title = "MOVIES"
        let highAverage = UIBarButtonItem(title: "High", style: .plain, target: self, action: #selector(didTapHighAverage))
        let lowAverage = UIBarButtonItem(title: "Low", style: .plain, target: self, action: #selector(didTapLowAverage))
        lowAverage.tintColor = UIColor(named: "foreGroundColor")
        highAverage.tintColor = UIColor(named: "foreGroundColor")
        navigationItem.rightBarButtonItem = lowAverage
        navigationItem.leftBarButtonItem = highAverage
    }

    @objc func didTapHighAverage() {
        dlog(self, "didTapHighAverageButton")
        presenter?.setDataForHighAverage()
    }

    @objc func didTapLowAverage() {
        dlog(self, "didTapLowAverageButton")
        presenter?.setDataForLowAverage()
    }

    func update(movies: [MovieResult]) {
        self.movies = movies
        localStorageService?.saveDataOf(movie: movies)
        localStorageService?.updateDataOffNetwork()
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    
    @IBAction func didTapFavoriteView(_ sender: Any){
        let favoriteVC = FavoriteViewControllerImpl(nibName: "FavoriteViewController", bundle: nil)
        navigationController?.pushViewController(favoriteVC, animated: true)
    }
    
    

    /* func updateFromCoreData(movies: [MovieResult]) {
         localStorageService?.updateDataOffNetwork()
         DispatchQueue.main.async {
             dlog(self, "update view with coredata")
             self.collectionView.reloadData()
         }
     } */
}

extension HomeViewControllerImpl {
    func showErrorAlert() {
    }
}

extension HomeViewControllerImpl {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let itemNumber = NSNumber(value: indexPath.item)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        let movie = movies[indexPath.row]

        cell.setup(itemNumber: itemNumber, movie)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detail = DetailsViewControllerImpl(nibName: "DetailsViewController", bundle: nil)
        movie = movies[indexPath.row]
        detail.movie = movie
        navigationController?.pushViewController(detail, animated: true)
    }
    
    func navigateToFavorite() {
        let favorite = FavoriteViewControllerImpl(nibName: "FavoriteViewController", bundle: nil)
        //favorite.modalPresentationStyle = .fullScreen
        navigationController?.popToViewController(favorite, animated: true)
       // navigationController?.pushViewController(favorite, animated: true)
    }
    
    
}

extension HomeViewControllerImpl: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width - 20) / 2, height: view.frame.height / 3)
    }
}

extension HomeViewControllerImpl: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == movies.count - 1 {
            presenter?.setData()
        }
    }
}
