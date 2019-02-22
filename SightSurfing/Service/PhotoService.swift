//
//  PhotoService.swift
//  SightSurfing
//
//  Created by Neo on 2019/2/9.
//  Copyright © 2019 STH. All rights reserved.
//

import Foundation

protocol PhotoServiceProtocol {
    func searchPhoto(keyword: String, page: Int, perPage: Int, complete: @escaping ([Photo], Int, Error?) -> Void)
}

enum PhotoRoute: String, Route {
    case search

    func path() -> String {
        return self.rawValue
    }
}

class PhotoService: PhotoServiceProtocol {

    private let service: NetworkService
    init(service: NetworkService = NetworkService()) {
        self.service = service
    }

    func searchPhoto(keyword: String, page: Int, perPage: Int, complete: @escaping ([Photo], Int, Error?) -> Void) {
        let networkComplete: (SearchResponse?, Error?) -> Void = { (response, error) in
            DispatchQueue.main.async {
                complete(response?.photos ?? [], response?.totalResults ?? 0, error)
            }
        }
        let param: [String: Any] = [
            "query": keyword,
            "per_page": perPage,
            "page": page
        ]
        service.getRequest(urlString: PhotoRoute.search.absoluteUrlString(),
                           header: nil,
                           parameter: param,
                           complete: networkComplete)
    }
}

class FakePhotoService: PhotoServiceProtocol {
    func searchPhoto(keyword: String, page: Int, perPage: Int, complete: @escaping ([Photo], Int, Error?) -> Void) {
        let networkComplete: (SearchResponse?, Error?) -> Void = { (response, error) in
            DispatchQueue.main.async {
                complete(response?.photos ?? [], response?.totalResults ?? 0, error)
            }
        }
        let jsonPath = Bundle.main.path(forResource: "response", ofType: "json")
        if let data = try? Data(contentsOf: URL(fileURLWithPath: jsonPath!)), var response = try? JSONDecoder().decode(SearchResponse.self, from: data) {
            DispatchQueue.global().async {
                sleep(6)
                response.page = page + 1
                response.totalResults = 31
                if page == 3 {
                    response.photos = [response.photos[0]]
                } else {
                    response.photos = Array(response.photos[0..<15])
                }
                networkComplete(response, nil)
            }
        }
    }
}
