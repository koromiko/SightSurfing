//
//  Photo.swift
//  SightSurfing
//
//  Created by Neo on 2019/2/19.
//  Copyright © 2019 STH. All rights reserved.
//

import Foundation

struct Photo: Decodable {
    let width: Double
    let height: Double
    let imageUrlString: String

    enum CodingKeys: String, CodingKey {
        case width
        case height
        case src
        case url
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        width = try values.decode(Double.self, forKey: .width)
        height = try values.decode(Double.self, forKey: .height)
        let src = try values.decode([String: String].self, forKey: .src)
        if let medium = src["medium"] {
            imageUrlString = medium
        } else {
            throw NSError(domain: "pexel.error", code: -1, userInfo: [NSLocalizedDescriptionKey: "Response format error"])
        }
    }
}
