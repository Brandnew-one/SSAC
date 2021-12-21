//
//  API.swift
//  TMDBtv
//
//  Created by 신상원 on 2021/12/21.
//

import Foundation

// MARK: - TVShow
struct TVShow: Codable {
    let page: Int
    let results: [Result]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct Result: Codable {
    let posterPath: String
    let voteAverage: Double
    let overview, firstAirDate: String
    let voteCount, id: Int
    let name, backdropPath, originalName: String
    let originCountry: [OriginCountry]
    let genreIDS: [Int]
    let originalLanguage: OriginalLanguage
    let popularity: Double
    let mediaType: MediaType

    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case overview
        case firstAirDate = "first_air_date"
        case voteCount = "vote_count"
        case id, name
        case backdropPath = "backdrop_path"
        case originalName = "original_name"
        case originCountry = "origin_country"
        case genreIDS = "genre_ids"
        case originalLanguage = "original_language"
        case popularity
        case mediaType = "media_type"
    }
}

enum MediaType: String, Codable {
    case tv = "tv"
}

enum OriginCountry: String, Codable {
    case es = "ES"
    case jp = "JP"
    case kr = "KR"
    case us = "US"
}

enum OriginalLanguage: String, Codable {
    case en = "en"
    case es = "es"
    case ja = "ja"
    case ko = "ko"
}
