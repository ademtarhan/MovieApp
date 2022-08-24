//
//  CollectionViewCell.swift
//  MovieApp
//
//  Created by Adem Tarhan on 17.08.2022.
//

import UIKit

class CollectionViewCell: UICollectionViewCell, APICallable {
    @IBOutlet var movieImage: UIImageView!

    @IBOutlet var movieVoteLabel: UILabel!

    @IBOutlet var movieNameLabel: UILabel!

    private let cache = NSCache<NSNumber, UIImage>()
    private let utilityQueue = DispatchQueue.global(qos: .utility)

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup(itemNumber: NSNumber, _ movie: MovieResult) {
        let url = URL(string: "\(imageBaseURL)\(movie.posterPath)")!

        movieNameLabel.text = movie.title
        movieVoteLabel.text = String(movie.voteAverage)

        loadImage(with: url) { image in
            guard let image = image else { return}

            self.cache.setObject(image, forKey: itemNumber)
            self.movieImage.image = image
        }
    }

    func loadImage(with url: URL, completionHandler: @escaping (UIImage?) -> Void) {
        utilityQueue.async {
            guard let data = try? Data(contentsOf: url) else { return }
            let imageToCache = UIImage(data: data)
            DispatchQueue.main.async {
                completionHandler(imageToCache)
            }
        }
//        DispatchQueue.global().async { [weak self] in
//            if let data = try? Data(contentsOf: url) {
//                if let image = UIImage(data: data) {
//                    DispatchQueue.main.async {
//                        self?.movieImage.image = image
//                    }
//                }
//            }
//        }
    }
}
