//
//  ProductModel.swift
//  amaro
//
//  Created by Rafael Aramizu Gomes on 09/12/2017.
//  Copyright © 2017 Eduardo Domene Junior. All rights reserved.
//

import Foundation
import Marshal

struct ProductModel: Unmarshaling{
    var name: String?
    var style: String?
    var codeColor: String?
    var colorSlug: String?
    var onSale: Bool?
    var regularPrice: String?
    var actualPrice: String?
    var discountPercentage: String?
    var installments: String?
    var image: String?
    var sizes: [SizeModel]?
}

extension ProductModel{
    init(object: MarshaledObject){
        name = try? object.value(for: "name")
        style = try? object.value(for: "style")
        codeColor = try? object.value(for: "code_color")
        colorSlug = try? object.value(for: "color_slug")
        onSale = try? object.value(for: "on_sale")
        regularPrice = try? object.value(for: "regular_price")
        actualPrice = try? object.value(for: "actual_price")
        discountPercentage = try? object.value(for: "discount_percentage")
        installments = try? object.value(for: "installments")
        image = try? object.value(for: "image")
        sizes = try? object.value(for: "sizes")
    }
}
