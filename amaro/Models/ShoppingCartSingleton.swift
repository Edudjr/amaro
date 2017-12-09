//
//  ShoppingCartSingleton.swift
//  amaro
//
//  Created by Rafael Aramizu Gomes on 09/12/2017.
//  Copyright © 2017 Eduardo Domene Junior. All rights reserved.
//

import Foundation

class ShoppingCartSingleton {
    static let sharedInstance = ShoppingCartSingleton()
    private var products = [ProductModel]()
    
    private init(){}
    
    public func addProductToCart(_ product: ProductModel){
        products.append(product)
    }
    
    public func removeProductFromCart(atIndex index: Int){
        guard index < products.count, index >= 0 else{
            return
        }
        
        products.remove(at: index)
    }
    
    public func removeAllFromCart(){
        products.removeAll()
    }
    
    public func getCartProducts()->[ProductModel]{
        return products
    }
}
