//
//  CustomTableViewCellController.swift
//  amaro
//
//  Created by Rafael Aramizu Gomes on 09/12/2017.
//  Copyright © 2017 Eduardo Domene Junior. All rights reserved.
//

import UIKit

class CustomTableViewCellController: UITableViewCell {
    @IBOutlet weak var item1: ItemViewController!
    @IBOutlet weak var item2: ItemViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
