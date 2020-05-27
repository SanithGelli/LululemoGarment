//
//  GarmentsTests.swift
//  GarmentsTests
//
//  Created by Sanith on 5/26/20.
//  Copyright © 2020 Sanith. All rights reserved.
//

import XCTest
@testable import Garments

class GarmentsTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testResultsWithAlpha() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let vc = ListViewModel()
        let results = vc.fetchRequest(index: 0)
        XCTAssertNotNil(results)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
