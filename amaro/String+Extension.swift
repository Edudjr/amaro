//
//  String+Extension.swift
//  amaro
//
//  Created by Rafael Aramizu Gomes on 09/12/2017.
//  Copyright © 2017 Eduardo Domene Junior. All rights reserved.
//

import Foundation

extension String {
    var currencyToDecimal : Decimal? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.currencySymbol = "R$ "
        
        if let number = formatter.number(from: self) {
            let amount = number.decimalValue
            return amount
        }else{
            return nil
        }
    }
}
