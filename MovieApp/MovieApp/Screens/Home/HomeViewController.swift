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
    var coreData: CoreData? { get set }
    func update(movies: [MovieResult])
    func showErrorAlert()

}

class HomeViewControllerImpl: UIViewController, HomeViewController, UICollectionViewDataSource {
    var movie: MovieResult?
    var movies = [MovieResult]()
    var presenter: HomePresenter?
    var coreData: CoreData?

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
        let highAverage = UIBarButtonItem(title: "High", style: .plain, target: self, action: #selector(didTapHighAverage))
        let lowAverage = UIBarButtonItem(title: "Low", style: .plain, target: self, action: #selector(didTapLowAverage))
        lowAverage.tintColor = UIColor(named: "foreGroundColor")
        highAverage.tintColor = UIColor(named: "foreGroundColor")
        navigationItem.rightBarButtonItem = lowAverage
        navigationItem.leftBarButtonItem = highAverage
    }

    /*
    @IBAction func didTapHighAverage(_ sender: Any) {
        print("did tap high")
        DispatchQueue.main.async {
            self.presenter?.setDataForHighAverage()
        }
    }

    @IBAction func didTapLowAverage(_ sender: Any) {
        DispatchQueue.main.async {
            self.presenter?.setDataForLowAverage()
        }
    }

     */
    @objc func didTapHighAverage() {
        dlog(self, "didTapHighAverageButton")
        presenter?.setDataForHighAverage()
    }

    @objc func didTapLowAverage() {
        dlog(self, "didTapLowAverageButton")
        presenter?.setDataForLowAverage()
    }

    func update(movies: [MovieResult]) {
        // self.movies.append(contentsOf: movies)

        DispatchQueue.main.async {
            self.movies = movies
            self.collectionView.reloadData()
            self.coreData?.saveDataOf(movie: movies)
        }
    }
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
