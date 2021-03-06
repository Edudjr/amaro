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
    case loadError
    case convertionError(fromString: String?, toType: String)
}

extension ProductsError: LocalizedError {
    public var localizedDescription: String {
        switch self {
        case .notFound:
            return NSLocalizedString("No products found", comment: "Products not found")
        case .loadError:
            return NSLocalizedString("Couldn't load products", comment: "Couldn't load")
        case .convertionError(let fromType, let toType):
            return NSLocalizedString("Couldn't convert \(String(describing: fromType)) to \(toType)", comment: "Convertion error")
        }
    }
}
