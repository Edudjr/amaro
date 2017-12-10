//
//  ViewController.swift
//  amaro
//
//  Created by Rafael Aramizu Gomes on 09/12/2017.
//  Copyright © 2017 Eduardo Domene Junior. All rights reserved.
//
import Foundation
import UIKit
import Kingfisher

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var filtroItem: UIBarButtonItem!
    @IBOutlet weak var salesButton: UIButton!
    
    var products = [ProductModel]()
    var currentPage = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = false
        tableView.allowsSelection = false
        salesButton.addTarget(self, action: #selector(onFiltroItemClicked(sender:)), for: .touchUpInside)
        
        //Register cell
        let nib = UINib(nibName: "CustomTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CustomTableViewCellIdentifier")
        
        fetchProducts(forPage: 1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func onFiltroItemClicked(sender: UIGestureRecognizer){
        print("OKOK")
    }
    
    internal func fetchProducts(forPage page: Int){
        ProductsStore.sharedInstance.getProducts(page: page) { (data, error) in
            guard error == nil, let data = data else {
                print("ERROR \(String(describing: error?.localizedDescription))")
                return
            }
            
            self.products.append(contentsOf: data)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    internal func setupCellItem(item: ItemViewController, product: ProductModel){
        item.delegate = self
        item.product = product
        item.descriptionLabel.text = product.name
        item.installmentsLabel.text = product.installments
        item.priceLabel.text = product.regularPrice
        
        if let onSale = product.onSale, onSale == true, let discount = product.discountPercentage {
            item.saleView.isHidden = false
            item.saleLabel.text = "\(discount)OFF"
            item.actualPriceLabel.isHidden = false
            item.actualPriceLabel.text = product.actualPrice
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: product.regularPrice!)
            attributeString.addAttribute(.strikethroughStyle, value: 1, range: NSMakeRange(0, attributeString.length))
            item.priceLabel.attributedText = attributeString
        }else{
            item.saleView.isHidden = true
            item.actualPriceLabel.isHidden = true
        }
        
        //Setup image
        if let imageURL = product.image, imageURL.isEmpty == false {
            let url = URL(string: imageURL)
            item.imageView?.kf.setImage(with: url)
            item.unavailableView.isHidden = true
        }else{
            item.unavailableView.isHidden = false
        }
    }
}

//MARK: UITableViewDataSource
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCellIdentifier", for: indexPath) as!
            CustomTableViewCellController
        
        let firstIndex = (indexPath.row * 2)
        let secondIndex = firstIndex + 1
        
        self.setupCellItem(item: cell.item1, product: products[firstIndex])
        if secondIndex < products.count {
            self.setupCellItem(item: cell.item2, product: products[secondIndex])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var result = Double(self.products.count/2)
        result = ceil(result)
        return Int(result)
    }
    
    //Infinite scroll
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastRow = Int(ceil(Double(products.count/2)))
        if indexPath.row == lastRow - 1{
            currentPage += 1
            fetchProducts(forPage: currentPage)
        }
    }
}


//MARK: UITableViewDelegate
extension ViewController: UITableViewDelegate{
    
}

extension ViewController: CustomItemViewControllerDelegate {
    func didClickOnItem(item: ItemViewController) {
        //
    }
    
    func didClickOnCart(item: ItemViewController) {
        if let product = item.product{
            ShoppingCartSingleton.sharedInstance.addProductToCart(product)
        }
        print(ShoppingCartSingleton.sharedInstance.getCartItems())
    }
}
