//
//  LoadFiles.swift
//  amaro
//
//  Created by Rafael Aramizu Gomes on 09/12/2017.
//  Copyright © 2017 Eduardo Domene Junior. All rights reserved.
//

import Foundation

class LoadFiles{
    static let sharedInstance = LoadFiles()
    
    private init(){}
    
    func productsData(completion:@escaping (Data?, Error?) ->Void){
        DispatchQueue.global().async {
            //find file
            guard let path = Bundle.main.path(forResource: "products", ofType: "json") else{
                DispatchQueue.main.async {
                    completion(nil, FilesError.notFound)
                }
                return
            }
            //Load file data
            guard let jsonData = (try? Data(contentsOf: URL(fileURLWithPath: path))) else{
                DispatchQueue.main.async {
                    completion(nil, FilesError.malformed)
                }
                return
            }
            completion(jsonData, nil)
        }
    }
}
