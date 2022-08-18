//
//  CollectionViewCell.swift
//  MovieApp
//
//  Created by Adem Tarhan on 17.08.2022.
//

import UIKit

class CollectionViewCell: UICollectionViewCell,APICallable {
    @IBOutlet var movieImage: UIImageView!

    @IBOutlet var movieVoteLabel: UILabel!

    @IBOutlet var movieNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(_ movie: MovieResult) {
        var url = URL(string: "\(imageBaseURL)\(movie.posterPath)")!
        movieNameLabel.text = movie.title
        loadImage(url: url) 
        movieVoteLabel.text = String(movie.voteAverage)
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
