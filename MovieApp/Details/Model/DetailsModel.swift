//
//  DetailsModel.swift
//  MovieApp
//
//  Created by Arthur Borges Conforti on 18/10/22.
//

import Foundation


struct DetailMovieResponse: Decodable {
    var adult: Bool
    var backdrop_path: String
    var budget: Int
    var homepage: String
    var id: Int
    var imdb_id: String
    var original_language: String
    var original_title: String
    var overview: String
    var popularity: Float
    var poster_path: String
    var release_date: String
    var revenue: Int
    var runtime: Int
    var status: String
    var tagline: String
    var title: String
    var video: Bool
    var vote_average: Float
    var vote_count: Int
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdrop_path
        case budget
        case homepage
        case id
        case imdb_id
        case original_language
        case original_title
        case overview
        case popularity
        case poster_path
        case release_date
        case revenue
        case runtime
        case status
        case tagline
        case title
        case video
        case vote_average
        case vote_count
    }
}

struct BelongsCollection: Decodable {
    var id: Int
    var name: String
    var poster_path: String
    var backdrop_path: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case poster_path
        case backdrop_path
    }
}

struct Genres: Decodable {
    var id: Int
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}

struct ProductCompanies: Decodable {
    var id: Int
    var logo_path: String?
    var name: String
    var origin_country: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case logo_path
        case name
        case origin_country
    }
}
struct ProductionCountries: Decodable {
    var iso_3166_1: String
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case iso_3166_1
        case name
    }
}

struct SpokenLanguages: Decodable {
    var english_name: String
    var iso_639_1: String
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case english_name
        case iso_639_1
        case name
    }
}
