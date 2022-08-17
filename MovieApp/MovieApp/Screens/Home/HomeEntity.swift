//
//  HomeEntity.swift
//  MovieApp
//
//  Created by Adem Tarhan on 16.08.2022.
//

import Foundation

protocol ResultImpl: AnyObject {
    var movie: MovieResult? { get }
}

struct MovieList: Codable {
    let movielist: Movie
}

// MARK: - Welcome

struct Movie: Codable {
    let results: [MovieResult]
}

// MARK: - CreatedBy

struct CreatedBy: Codable {
    let gravatarHash, id, name, username: String

    enum CodingKeys: String, CodingKey {
        case gravatarHash = "gravatar_hash"
        case id, name, username
    }
}

enum ISO639_1: String, Codable {
    case en
}

// MARK: - Result

struct MovieResult: Codable {
    let adult: Bool
    let backdropPath: String
    let genreIDS: [Int]
    let id: Int
    let originalLanguage: ISO639_1
    let originalTitle, overview: String
    let popularity: Double
    let posterPath, releaseDate, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

enum MovieError: Error {
    case invalidURL(String)
    case invalidPayload(URL)
    case forwarded(Error)
    case nilMovie(MovieResult)
}
