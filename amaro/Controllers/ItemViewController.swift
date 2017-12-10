//
//  ItemViewController.swift
//  amaro
//
//  Created by Rafael Aramizu Gomes on 09/12/2017.
//  Copyright © 2017 Eduardo Domene Junior. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class ItemViewController: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var innerContentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var unavailableView: UIView!
    @IBOutlet weak var saleView: UIView!
    let nibName : String? = "ItemView"
    @IBOutlet weak var saleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var actualPriceLabel: UILabel!
    @IBOutlet weak var installmentsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        xibSetup()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        xibSetup()
        contentView?.prepareForInterfaceBuilder()
    }
    
    func xibSetup() {
        guard let view = loadViewFromNib() else {
            return
        }
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView = view
        //setupBorder()
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView? {
        guard let nibName = nibName else { return nil }
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(
            withOwner: self,
            options: nil).first as? UIView
    }
    
    func setupBorder(){
        innerContentView.layer.cornerRadius = 10
    }
}
