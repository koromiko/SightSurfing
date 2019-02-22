//
//  Route.swift
//  SightSurfing
//
//  Created by Neo on 2019/2/18.
//  Copyright © 2019 STH. All rights reserved.
//

import Foundation

protocol Route {
    var host: String { get }
    func path() -> String
}

extension Route {
    var host: String {
        return "https://api.pexels.com/v1/"
    }

    /// Get the absolute URL of this route
    func absoluteUrlString() -> String {
        guard var url = URL(string: host) else {
            assert(false, "host is not an url")
        }
        url.appendPathComponent(path())
        return url.absoluteString
    }
}
