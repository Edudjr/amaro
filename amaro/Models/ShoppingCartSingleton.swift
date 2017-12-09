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
    private var items = [ShoppingCartItemModel]()
    
    private init(){}
    
    
    // Assuming that "name" is a unique identifier
    public func addProductToCart(_ product: ProductModel){
        if let index = items.index(where: {$0.product.name == product.name}) {
            items[index].quantity += 1
        } else {
            let item = ShoppingCartItemModel(product: product, quantity: 1)
            items.append(item)
        }
    }
    
    // Assuming that "name" is a unique identifier
    public func removeProductFromCart(_ product: ProductModel){
        if let index = items.index(where: {$0.product.name == product.name}) {
            items[index].quantity -= 1
            if (items[index].quantity == 0){
                items.remove(at: index)
            }
        }
    }
    
    public func removeAllFromCart(){
        items.removeAll()
    }
    
    public func getCartItems()->[ShoppingCartItemModel]{
        return items
    }
    
    public func getTotalAmount() throws -> Decimal{
        var total = Decimal()
        for item in items {
            guard let price = item.product.actualPrice?.currencyToDecimal else{
                throw ProductsError.convertionError(fromString: item.product.actualPrice, toType: "decimal")
            }
            let finalPrice = price * Decimal(item.quantity)
            total += finalPrice
        }
        return total
    }
}
