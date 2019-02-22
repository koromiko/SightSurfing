//
//  SightSurfingTests.swift
//  SightSurfingTests
//
//  Created by Neo on 2019/2/9.
//  Copyright © 2019 STH. All rights reserved.
//

import XCTest
@testable import SightSurfing

class SightSurfingTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDecoder() {
        let path = Bundle(for: type(of: self)).path(forResource: "response", ofType: "json")
        let data = try? Data(contentsOf: URL(fileURLWithPath: path!))
        let jsonDecoder = JSONDecoder()

        let response = try? jsonDecoder.decode(SearchResponse.self, from: data!)
        XCTAssertEqual(response!.photos.count, 15)
        XCTAssertEqual(response?.photos.first?.imageUrlString ?? "", "https://images.pexels.com/photos/1134166/pexels-photo-1134166.jpeg?auto=compress&cs=tinysrgb&h=350")
    }

}
