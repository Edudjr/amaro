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
    
    func testProductsStore(){
        let expectation = XCTestExpectation(description: "Get Products from Store with page 0")
        
        ProductsStore.sharedInstance.getProducts(page: 0) { (data, error) in
            XCTAssertNotNil(error, "Error should not be nil")
            XCTAssertNil(data, "Data should be nil")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testProductsStoreWithNegativePage(){
        let expectation = XCTestExpectation(description: "Get Products from Store with page -1")
        
        ProductsStore.sharedInstance.getProducts(page: -1) { (data, error) in
            XCTAssertNotNil(error, "Error should not be nil")
            XCTAssertNil(data, "Data should be nil")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testProductsStoreWithValidIndexPage(){
        let expectation1 = XCTestExpectation(description: "Get Products from Store with page 1")
        let expectation2 = XCTestExpectation(description: "Get Products from Store with page 2")
        let expectation3 = XCTestExpectation(description: "Get Products from Store with page 3")
        
        ProductsStore.sharedInstance.getProducts(page: 1) { (data, error) in
            XCTAssertNil(error, "Error should be nil")
            XCTAssertNotNil(data, "Data should not be nil")
            XCTAssertTrue((data as Any) is [ProductModel], "data is not array of ProductModel")
            expectation1.fulfill()
        }
        ProductsStore.sharedInstance.getProducts(page: 2) { (data, error) in
            XCTAssertNil(error, "Error should be nil")
            XCTAssertNotNil(data, "Data should not be nil")
            XCTAssertTrue((data as Any) is [ProductModel], "data is not array of ProductModel")
            expectation2.fulfill()
        }
        ProductsStore.sharedInstance.getProducts(page: 3) { (data, error) in
            XCTAssertNil(error, "Error should be nil")
            XCTAssertNotNil(data, "Data should not be nil")
            XCTAssertTrue((data as Any) is [ProductModel], "data is not array of ProductModel")
            expectation3.fulfill()
        }
        
        wait(for: [expectation1], timeout: 10.0)
        wait(for: [expectation2], timeout: 10.0)
        wait(for: [expectation3], timeout: 10.0)
    }
    
    func testProductsStoreWithInvalidIndexPage(){
        let expectation = XCTestExpectation(description: "Get Products from Store with page 1")
        
        ProductsStore.sharedInstance.getProducts(page: 4) { (data, error) in
            XCTAssertNotNil(error, "Error should not be nil")
            XCTAssertNil(data, "Data should be nil")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
}
