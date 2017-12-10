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
    let nibName : String? = "ItemView"
    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        UINib(nibName: "ItemView", bundle: nil).instantiate(withOwner: self, options: nil)
//        contentView.frame = self.bounds
//        addSubview(contentView)
//    }
    
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
        addSubview(view)
        contentView = view
    }
    
    func loadViewFromNib() -> UIView? {
        guard let nibName = nibName else { return nil }
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(
            withOwner: self,
            options: nil).first as? UIView
    }
}
