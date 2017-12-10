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
        //var cart = UserModelSingleton.sharedInstance.shoppingCart
        ShoppingCartSingleton.sharedInstance.removeAllFromCart()
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
            XCTAssertEqual(data?.count, 10)
            expectation1.fulfill()
        }
        ProductsStore.sharedInstance.getProducts(page: 2) { (data, error) in
            XCTAssertNil(error, "Error should be nil")
            XCTAssertNotNil(data, "Data should not be nil")
            XCTAssertTrue((data as Any) is [ProductModel], "data is not array of ProductModel")
            XCTAssertEqual(data?.count, 10)
            expectation2.fulfill()
        }
        ProductsStore.sharedInstance.getProducts(page: 3) { (data, error) in
            XCTAssertNil(error, "Error should be nil")
            XCTAssertNotNil(data, "Data should not be nil")
            XCTAssertTrue((data as Any) is [ProductModel], "data is not array of ProductModel")
            XCTAssertEqual(data?.count, 2)
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
    
    func testProductsStoreOnSale(){
        let expectation = XCTestExpectation(description: "Get Products from Store that are on sale")
        
        ProductsStore.sharedInstance.getProductsOnSale(page: 1) { (data, error) in
            XCTAssertNil(error, "Error should be nil")
            XCTAssertNotNil(data, "Data should not be nil")
            XCTAssertEqual(data?.count, 8)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testProductsStoreOnSaleInvalidIndexPage(){
        let expectation = XCTestExpectation(description: "Get Products from Store that are on sale")
        
        ProductsStore.sharedInstance.getProductsOnSale(page: 2) { (data, error) in
            XCTAssertNotNil(error, "Error should not be nil")
            XCTAssertNil(data, "Data should be nil")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testEmptyShoppingCart(){
        let count = ShoppingCartSingleton.sharedInstance.getCartItems().count
        XCTAssertEqual(count, 0)
    }
    
    func testAddDifferentProductsToShoppingCart(){
        var product1 = ProductModel()
        var product2 = ProductModel()

        product1.name = "VESTIDO"
        product2.name = "REGATA"

        ShoppingCartSingleton.sharedInstance.addProductToCart(product1)
        ShoppingCartSingleton.sharedInstance.addProductToCart(product2)
        
        var items = ShoppingCartSingleton.sharedInstance.getCartItems()
        let count = items.count

        XCTAssertEqual(count, 2)
        XCTAssertEqual(items[0].product?.name, "VESTIDO")
        XCTAssertEqual(items[0].quantity, 1)
        XCTAssertEqual(items[1].product?.name, "REGATA")
        XCTAssertEqual(items[1].quantity, 1)
    }
    
    func testAddSameProductToShoppingCart(){
        var product1 = ProductModel()
        
        product1.name = "VESTIDO"
        
        ShoppingCartSingleton.sharedInstance.addProductToCart(product1)
        ShoppingCartSingleton.sharedInstance.addProductToCart(product1)
        
        var items = ShoppingCartSingleton.sharedInstance.getCartItems()
        let count = items.count
        
        XCTAssertEqual(count, 1)
        XCTAssertEqual(items[0].product?.name, "VESTIDO")
        XCTAssertEqual(items[0].quantity, 2)
    }
    
    func testRemoveAllProductsFromShoppingCart(){
        let product1 = ProductModel()
        let product2 = ProductModel()

        ShoppingCartSingleton.sharedInstance.addProductToCart(product1)
        ShoppingCartSingleton.sharedInstance.addProductToCart(product2)

        ShoppingCartSingleton.sharedInstance.removeAllFromCart()

        let count = ShoppingCartSingleton.sharedInstance.getCartItems().count

        XCTAssertEqual(count, 0)
    }
    
    func testRemoveProductWithQuantityOne(){
        let cart = ShoppingCartSingleton.sharedInstance
        var product = ProductModel()
        product.name = "VESTIDO"
        
        cart.addProductToCart(product)
        cart.removeProductFromCart(product)
        
        XCTAssertEqual(cart.getCartItems().count, 0)
    }
    
    func testRemoveProductWithQuantityTwo(){
        let cart = ShoppingCartSingleton.sharedInstance
        var product = ProductModel()
        product.name = "VESTIDO"
        
        cart.addProductToCart(product)
        cart.addProductToCart(product)
        cart.removeProductFromCart(product)
        
        let count = cart.getCartItems().count
        XCTAssertEqual(count, 1)
        if (count >= 0){
            let item = cart.getCartItems()[0]
            XCTAssertEqual(item.quantity, 1)
        }
    }
    
    func testCurrencyToDecimal() {
        let price = "R$ 139,90"
        let value = price.currencyToDecimal
        XCTAssertEqual(value, 139.90)
    }
    
    func testDecimalToCurrency() {
        let price = Decimal(139.90)
        let value = price.decimalToCurrency
        XCTAssertEqual(value, "R$ 139,90")
    }
    
    func testCartTotalAmount(){
        let cart = ShoppingCartSingleton.sharedInstance
        var product = ProductModel()
        var product2 = ProductModel()
        
        product.name = "VESTIDO"
        product.actualPrice = "R$ 20,10"
        
        product2.name = "BLUSA"
        product2.actualPrice = "R$ 10,00"
        
        cart.addProductToCart(product)
        cart.addProductToCart(product)
        cart.addProductToCart(product2)
        
        let total = try? cart.getTotalAmount()
        XCTAssertEqual(total, Decimal(50.20))
    }
}
