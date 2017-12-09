//
//  SizeModel.swift
//  amaro
//
//  Created by Rafael Aramizu Gomes on 09/12/2017.
//  Copyright © 2017 Eduardo Domene Junior. All rights reserved.
//

import Foundation
import Marshal

struct SizeModel: Unmarshaling{
    var available: Bool?
    var size: String?
    var sku: String?
    
    init(object: MarshaledObject){
        available = try? object.value(for: "available")
        size = try? object.value(for: "size")
        sku = try? object.value(for: "sku")
    }
}
