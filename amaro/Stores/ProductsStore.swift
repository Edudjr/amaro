//
//  ProductsStore.swift
//  amaro
//
//  Created by Rafael Aramizu Gomes on 09/12/2017.
//  Copyright © 2017 Eduardo Domene Junior. All rights reserved.
//

import Foundation

/*
 * ProductsStore is a singleton that manages products data fetching
 */
class ProductsStore {
    
    static let sharedInstance = ProductsStore()
    private let perPage = 10
    
    private init(){}
    
    func getProducts(page: Int, completion: @escaping([ProductModel]?, ProductsError?)->Void){
        guard page > 0 else{
            completion(nil, ProductsError.loadError)
            return
        }
        
        LoadFiles.sharedInstance.productsData { (data, error) in
            var productList = [ProductModel]()
            
            if let error = error {
                completion(nil, ProductsError.loadError)
                print(error)
                return
            }
            
            if let data = data {
                guard let json = try? JSONSerialization.jsonObject(with: data, options: []) else{
                    completion(nil, ProductsError.loadError)
                    return
                }
                
                if let json = json as? [String:Any]{
                    //get "products" key
                    if let products = json["products"] as? [[String: Any]]{
                        //iterate and create models
                        for p in products{
                            let product = ProductModel(object: p)
                            productList.append(product)
                        }
                    }
                }
            }
            //fake pagination
            let offset = (page-1) * self.perPage
            if offset < productList.count {
                productList = Array(productList[offset...])
            }else{
                completion(nil, ProductsError.notFound)
                return
            }
            
            completion(productList, nil)
        }
    }
    
}
