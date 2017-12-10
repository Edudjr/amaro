//
//  ItemViewController.swift
//  amaro
//
//  Created by Rafael Aramizu Gomes on 09/12/2017.
//  Copyright © 2017 Eduardo Domene Junior. All rights reserved.
//

import Foundation
import UIKit


protocol CustomItemViewControllerDelegate {
    func didClickOnItem(item: ItemViewController)
    func didClickOnCart(item: ItemViewController)
}

@IBDesignable
class ItemViewController: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var innerContentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var unavailableView: UIView!
    @IBOutlet weak var saleView: UIView!
    @IBOutlet weak var saleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var actualPriceLabel: UILabel!
    @IBOutlet weak var installmentsLabel: UILabel!
    @IBOutlet weak var cartButton: UIButton!
    @IBOutlet weak var sizeLabel: UILabel!
    
    let nibName : String? = "ItemView"
    var product: ProductModel?
    var delegate: CustomItemViewControllerDelegate?
    
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
        addSubview(view)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didClickOnCart(sender:)))
        cartButton.addGestureRecognizer(tap)
        let tapItem = UITapGestureRecognizer(target: self, action: #selector(didClickOnItem(sender:)))
        contentView.addGestureRecognizer(tapItem)
    }
    
    @objc func didClickOnItem(sender: UIGestureRecognizer){
        self.delegate?.didClickOnItem(item: self)
    }
    @objc func didClickOnCart(sender: UIGestureRecognizer){
        self.delegate?.didClickOnCart(item: self)
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
