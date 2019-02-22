//
//  AuthService.swift
//  SightSurfing
//
//  Created by Neo on 2019/2/19.
//  Copyright © 2019 STH. All rights reserved.
//

import Foundation

/// Conform this protocol to provide auth token to the NetworkService
protocol AuthServiceProtocol {
    func authenticateHeader(header: [String: String]?) -> [String: String]
}

/// Use the pre-saved API token to authenticate the network services
class LocalAuthService: AuthServiceProtocol {
    // Specified the token file, please remember to remove the file from git or other source controll system if the project is public
    private var tokenFilePath: String? {
        return Bundle.main.path(forResource: "token", ofType: "txt")
    }

    /// Please fill in your access token in the token.txt file
    func authenticateHeader(header: [String: String]?) -> [String: String] {
        guard let path = tokenFilePath else {
            assert(false, "Token file does not exist")
            return [:]
        }

        do {
            let token = try String(contentsOfFile: path)
            var authHeader: [String: String] = ["Authorization": token]
            if let header = header {
                authHeader.merge(header) { (_, custom) in custom }
            }
            return authHeader
        } catch let error {
            assert(false, error.localizedDescription)
            return [:]
        }
    }
}
