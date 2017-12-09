//
//  Decimal+Extension.swift
//  amaro
//
//  Created by Rafael Aramizu Gomes on 09/12/2017.
//  Copyright © 2017 Eduardo Domene Junior. All rights reserved.
//

import Foundation

extension Decimal {
    var decimalToCurrency : String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.currencySymbol = "R$ "
        
        if let formatted = formatter.string(from: self as NSNumber) {
            return formatted
        }else{
            return nil
        }
    }
}
