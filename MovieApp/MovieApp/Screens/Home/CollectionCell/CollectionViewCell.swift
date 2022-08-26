//
//  CollectionViewCell.swift
//  MovieApp
//
//  Created by Adem Tarhan on 17.08.2022.
//

import Alamofire
import Kingfisher
import UIKit

class CollectionViewCell: UICollectionViewCell, APICallable {
    @IBOutlet var movieImage: UIImageView!

    @IBOutlet var movieVoteLabel: UILabel!

    @IBOutlet var movieNameLabel: UILabel!

    var imageCache = NSCache<AnyObject, AnyObject>()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup(itemNumber: NSNumber, _ movie: MovieResult) {
        let imageURL = "\(imageBaseURL)\(movie.posterPath)"

        movieNameLabel.text = movie.title
        movieVoteLabel.text = String(movie.voteAverage)

        getImage(for: imageURL)
    }

    // MARK: NSCache

    func getImage(for url: String?) {
        guard let url = url else {
            return
        }
        let key = url as NSString

        if let image = imageCache.object(forKey: key) {
            guard let image = image as? UIImage else {
                return
            }
            movieImage.image = image
        } else {
            AF.request(url, method: .get).response { response in
                switch response.result {
                case let .success(responseData):
                    let image = UIImage(data: responseData!, scale: 1)
                    guard let im = image else {
                        return
                    }
                    self.movieImage.image = image
                    self.imageCache.setObject(im, forKey: key)
                case let .failure(error):
                    print("error--->", error)
                }
            }
        }
    }
}
