//
//  SearchResponse.swift
//  SightSurfing
//
//  Created by Neo on 2019/2/19.
//  Copyright © 2019 STH. All rights reserved.
//

import Foundation

struct SearchResponse: Decodable {
    var page: Int
    let perPage: Int
    var totalResults: Int
    var photos: [Photo]

    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case totalResults = "total_results"
        case photos
    }

}
