//
//  MoviesResponse.swift
//  MoviesListTest
//
//  Created by Sofiia Lushchanets on 24.11.2020.
//

import Foundation

struct MoviesResponse: Decodable {
    let results: [Movie]
}
