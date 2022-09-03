//
//  DetailViewController.swift
//  MovieApp
//
//  Created by Adem Tarhan on 26.08.2022.
//

import UIKit

protocol DetailsViewController: AnyObject {
    var favorite: FavoriteViewController? {get set}
    var favoriMovies : [MovieResult] { get set }
    var movie: MovieResult? { get set }
}

class DetailsViewControllerImpl: UIViewController, DetailsViewController, APICallable {
    var favorite: FavoriteViewController?
    
    var movie: MovieResult?
    var favoriMovies = [MovieResult]()
   
    
    @IBOutlet var movieImage: UIImageView!
    @IBOutlet var movieTitleLabel: UILabel!
    @IBOutlet var movieVoteLabel: UILabel!
    @IBOutlet var movieDateLabel: UILabel!
    @IBOutlet var movieOverview: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Favorite", style: .plain, target: self, action: #selector(addToFavorite))

        guard let path = movie?.posterPath else { return }
        let url = URL(string: "\(imageBaseURL)\(path)")!
        loadImage(url: url)
        movieTitleLabel.text = movie?.title
        movieOverview.text = movie?.overview
        movieDateLabel.text = movie?.releaseDate
        movieVoteLabel.text = String(movie!.voteAverage)
    }

    @objc func addToFavorite() {
        favorite?.favoriteMovies.append(self.movie!)
        favoriMovies.append(movie!)
        dlog(self, "\(favorite?.favoriteMovies.count)")
        dlog(self, "\(favoriMovies.count)")
    }

    func loadImage(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.movieImage.image = image
                    }
                }
            }
        }
    }
}

// .. https://image.tmdb.org/t/p/w500/uJYYizSuA9Y3DCs0qS4qWvHfZg4.jpg
extension DetailsViewControllerImpl {
    func loadImage(movieImage: UIImage, path: String!) {
        let url = "\(imageBaseURL)\(path!)"
        let imageURL = URL(string: url)

        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: imageURL!) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        let movieImage = image
                    }
                }
            }
        }
    }
}
