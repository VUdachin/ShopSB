//
//  CartVC.swift
//  BS_Shop
//
//  Created by Vladimir Udachin on 13.02.2020.
//  Copyright © 2020 Vladimir Udachin. All rights reserved.
//

import UIKit
import RealmSwift

class CartVC: UIViewController {

    private lazy var realm = try! Realm()
    
    @IBOutlet weak var mainCartTableView: UITableView!
    
    @IBOutlet weak var allCartCostLabel: UILabel!
    @IBOutlet weak var allCartProductsLabel: UILabel!
    
    
    
    var addedProducts: Results<CartProduct> {
        get {
            return realm.objects(CartProduct.self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainCartTableView.reloadData()
        
    }
    
    @IBAction func order(_ sender: Any) {
        
        try! self.realm.write {
            self.realm.deleteAll()
        }
        mainCartTableView.reloadData()
        
        let alert = UIAlertController(title: "Товары заказаны!", message: "Спасибо, что покупаете у нас", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Ок", style: .cancel, handler: nil)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    
}

extension CartVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addedProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath) as! CartTableVCell
        let prod = addedProducts[indexPath.row]
        
        DispatchQueue.main.async {
            let imageUrl = URL(string: "https://blackstarshop.ru/\(prod.productImage)")
            cell.cartImageView.image = UIImage(data: try! Data(contentsOf: imageUrl!))
        }
        
        cell.cartNameLabel.text = prod.productName
        cell.cartCostLabel.text = "Стоимость: \(prod.productPrice.replacingOccurrences(of: ".0000", with: "₽"))"
        cell.cartSizeLabel.text = "Размер: \(prod.productSize)"
        
        
        return cell
    }
    
    
}
