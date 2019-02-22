//
//  NetworkService.swift
//  SightSurfing
//
//  Created by Neo on 2019/2/9.
//  Copyright © 2019 STH. All rights reserved.
//

import Foundation

class NetworkService {
    private let session: URLSession
    private let authService: AuthServiceProtocol
    init(session: URLSession = URLSession.shared, authService: AuthServiceProtocol = LocalAuthService()) {
        self.session = session
        self.authService = authService
    }

    /// Make a http GET reqeust
    func getRequest<T: Decodable>(urlString: String, header: [String: String]?, parameter: [String: Any]?, complete: @escaping (T?, Error?) -> Void) {
        let request = compostRequest(urlString: urlString, header: header, parameter: parameter)
        session.dataTask(with: request) { (data, response, error) in
            if let data = data, let response = response as? HTTPURLResponse, (200..<300).contains(response.statusCode) {
                do {
                    let jsonDecoder = JSONDecoder()
                    let result = try jsonDecoder.decode(T.self, from: data)
                    complete(result, nil)
                } catch let error {
                    complete(nil, error)
                }
            } else {
                complete(nil, error)
            }
        }.resume()
    }

    private func compostRequest(urlString: String, header: [String: String]?, parameter: [String: Any]?) -> URLRequest {
        let urlWithQuery = urlString.appending(urlQuery(parameters: parameter))
        var request = URLRequest(url: URL(string: urlWithQuery)!)
        request.allHTTPHeaderFields = authService.authenticateHeader(header: header)
        return request
    }

    private func urlQuery(parameters: [String: Any]?) -> String {
        var urlQuery: [String] = []
        if let parameters = parameters {
            urlQuery = parameters.reduce(into: urlQuery) { (res, tup) in
                let (key, value) = tup
                res.append("\(key)=\(value)")
            }
        }
        return "?\(urlQuery.joined(separator: "&"))"
    }
}
