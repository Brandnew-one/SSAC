//
//  TVSearchModel.swift
//  TMDBtv
//
//  Created by 신상원 on 2021/12/29.
//

import Foundation

// MARK: - Search
struct TVSearch: Codable {
    let page: Int
    let results: [ResultSearch]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct ResultSearch: Codable {
    let adult: Bool
    let gender, id: Int
    let knownFor: [KnownFor]
    let knownForDepartment, name: String
    let popularity: Double
    let profilePath: String

    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownFor = "known_for"
        case knownForDepartment = "known_for_department"
        case name, popularity
        case profilePath = "profile_path"
    }
}

// MARK: - KnownFor
struct KnownFor: Codable {
    let backdropPath: String
    let firstAirDate: String?
    let genreIDS: [Int]
    let id: Int
    let mediaType: String
    let name: String?
    let originCountry: [String]?
    let originalLanguage: String
    let originalName: String?
    let overview, posterPath: String
    let voteAverage: Double
    let voteCount: Int
    let adult: Bool?
    let originalTitle, releaseDate, title: String?
    let video: Bool?

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case firstAirDate = "first_air_date"
        case genreIDS = "genre_ids"
        case id
        case mediaType = "media_type"
        case name
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case adult
        case originalTitle = "original_title"
        case releaseDate = "release_date"
        case title, video
    }
}
