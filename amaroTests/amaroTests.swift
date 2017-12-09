//
//  amaroTests.swift
//  amaroTests
//
//  Created by Rafael Aramizu Gomes on 09/12/2017.
//  Copyright © 2017 Eduardo Domene Junior. All rights reserved.
//

import XCTest
@testable import amaro

class amaroTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLoadProductsFile(){
        // Create an expectation for a background download task.
        let expectation = XCTestExpectation(description: "Load Products File")
        
        LoadFiles.sharedInstance.productsData { (data, error) in
            XCTAssertNotNil(data, "Couldn't load file. No data.")
            XCTAssertNil(error, "Couldn't load file. Found Error.")
            expectation.fulfill()
        }
        
        // Wait until the expectation is fulfilled, with a timeout of 10 seconds.
        wait(for: [expectation], timeout: 10.0)
    }
    
}
