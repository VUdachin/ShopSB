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
    
    @IBOutlet private weak var allCartCostLabel: UILabel!
    @IBOutlet private weak var allCartProductsLabel: UILabel!
    
    var addedProducts: Results<CartProduct> {
        get {
            return realm.objects(CartProduct.self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allCartProductsLabel.text = "Количество товаров: \(addedProducts.count)"
        mainCartTableView.reloadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
        cell.configureCell(content: prod)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let prod = addedProducts[indexPath.row]
            
            try! self.realm.write {
                self.realm.delete(prod)
            }
            
            mainCartTableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
}
