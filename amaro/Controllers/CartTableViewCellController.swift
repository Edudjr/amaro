//
//  CartTableViewCellController.swift
//  amaro
//
//  Created by Rafael Aramizu Gomes on 10/12/2017.
//  Copyright © 2017 Eduardo Domene Junior. All rights reserved.
//

import UIKit
protocol CartTableViewCellControllerDelegate {
    func didClickAtPlus(_ item: ShoppingCartItemModel?)
    func didClickAtMinus(_ item: ShoppingCartItemModel?)
}
class CartTableViewCellController: UITableViewCell{
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var installmentsLabel: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var countLabel: UILabel!
    
    var delegate: CartTableViewCellControllerDelegate?
    var item: ShoppingCartItemModel?
    
    @IBAction func clickAtPlus(_ sender: UIButton) {
        self.delegate?.didClickAtPlus(item)
    }
    
    @IBAction func clickAtMinus(_ sender: UIButton) {
        self.delegate?.didClickAtMinus(item)
    }
}
