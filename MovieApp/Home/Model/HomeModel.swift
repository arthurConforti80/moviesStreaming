//
//  HomeModel.swift
//  MovieApp
//
//  Created by Arthur Borges Conforti on 16/10/22.
//

import Foundation

struct GenresResponse: Decodable {
    var genres: [ItensGenres]
    
    enum CodingKeys: String, CodingKey {
      case genres
    }
}

struct ItensGenres: Decodable {
    var id: Int
    var name: String
    
    enum CodingKeys: String, CodingKey {
      case id
      case name
    }
}

struct ListMovieResponse: Decodable {
    var page: Int
    var results: [ItensMovies]
    var total_pages: Int
    var total_results: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case total_pages
        case total_results
    }
}

struct ItensMovies: Decodable {
    var adult: Bool
    var backdrop_path: String
    var genre_ids: [Int]
    var id: Int
    var original_language: String
    var original_title: String
    var overview: String
    var popularity: Float
    var poster_path: String
    var release_date: String
    var title: String
    var video: Bool
    var vote_average: Float
    var vote_count: Float
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdrop_path
        case genre_ids
        case id
        case original_language
        case original_title
        case overview
        case popularity
        case poster_path
        case release_date
        case title
        case video
        case vote_average
        case vote_count
    }
}
