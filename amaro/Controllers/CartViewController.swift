//
//  CartViewController.swift
//  amaro
//
//  Created by Rafael Aramizu Gomes on 10/12/2017.
//  Copyright © 2017 Eduardo Domene Junior. All rights reserved.
//

import UIKit

class CartViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var totalLabel: UILabel!
    
    let cart = ShoppingCartSingleton.sharedInstance
    //var items = [ShoppingCartItemModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let total = try? cart.getTotalAmount().decimalToCurrency else {
            return
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        reloadData()
    }
}

extension CartViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart.getCartItems().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartCellIdentifier", for: indexPath) as! CartTableViewCellController
        let item = cart.getCartItems()[indexPath.row]
        
        guard let quantity = item.quantity else{
            return cell
        }
        
        let url = URL(string: item.product?.image ?? "")
        cell.imgView.kf.setImage(with: url)
        cell.descriptionLabel.text = item.product?.name
        cell.priceLabel.text = item.product?.actualPrice
        cell.installmentsLabel.text = item.product?.installments
        cell.countLabel.text = "Quantidade: \(quantity)"
        cell.item = item
        cell.delegate = self
        return cell
    }
    
    
    internal func reloadData(){
        guard let total = try? cart.getTotalAmount().decimalToCurrency else {
            return
        }
        totalLabel.text = total
        tableView.reloadData()
        if (cart.getCartItems().count <= 0){
            emptyView.isHidden = false
        }else{
            emptyView.isHidden = true
        }
    }
    
    internal func subtractItem(product: ProductModel){
        cart.removeProductFromCart(product)
        reloadData()
    }
    
    internal func addItem(product: ProductModel){
        cart.addProductToCart(product)
        reloadData()
    }
}

extension CartViewController: UITableViewDelegate {
    
}

extension CartViewController: CartTableViewCellControllerDelegate{
    func didClickAtPlus(_ item: ShoppingCartItemModel?) {
        if let item = item {
            for element in cart.getCartItems() {
                if element == item {
                    addItem(product: element.product!)
                }
            }
        }
    }
    
    func didClickAtMinus(_ item: ShoppingCartItemModel?) {
        if let item = item {
            for element in cart.getCartItems() {
                if element == item {
                    subtractItem(product: element.product!)
                }
            }
        }
    }
    
    
}
