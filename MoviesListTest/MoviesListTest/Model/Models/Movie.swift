//
//  Movie.swift
//  MoviesListTest
//
//  Created by Sofiia Lushchanets on 24.11.2020.
//

import Foundation

struct Movie {
    let title: String
    let poster: String
    let overview: String
}

// MARK: - CodingKeys
extension Movie: Decodable {
    private enum CodingKeys: String, CodingKey {
        case title
        case poster = "poster_path"
        case overview
    }
}
