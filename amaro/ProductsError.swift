//
//  ProductsError.swift
//  amaro
//
//  Created by Rafael Aramizu Gomes on 09/12/2017.
//  Copyright © 2017 Eduardo Domene Junior. All rights reserved.
//

import Foundation

enum ProductsError: Error {
    case notFound
}

extension ProductsError: LocalizedError {
    public var localizedDescription: String {
        switch self {
        case .notFound:
            return NSLocalizedString("No products found", comment: "Products not found")
        }
    }
}
