//
//  ProductCartVC.swift
//  BS_Shop
//
//  Created by Vladimir Udachin on 07.02.2020.
//  Copyright © 2020 Vladimir Udachin. All rights reserved.
//

import UIKit
import RealmSwift

class ProductCartVC: UIViewController {

    private lazy var realm = try! Realm()
    
    
    @IBOutlet weak var cartCV: UICollectionView!

    @IBOutlet private weak var priceCartLabel: UILabel!
    @IBOutlet private weak var nameCartLabel: UILabel!
    @IBOutlet private weak var colorLabel: UILabel!
    
    @IBOutlet private weak var sizeButton: UIButton!
    @IBOutlet private weak var addToBucketButton: UIButton!
    
    @IBOutlet private weak var descriptionTextView: UITextView!
    
    var cartProd: ProductValue?
    
    var imageArr: [String] = []
    
    var selectedSize: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataProcessing()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? SizeVC, segue.identifier == "changeSize" {
            vc.sizes = (cartProd?.offers)!
            vc.delegate = self
        }
    }
    
    
    func dataProcessing() {
        DispatchQueue.main.async {
            for i in (self.cartProd?.productImages)! {
                self.imageArr.append("\(i.imageURL!)")
            }
            self.cartCV.reloadData()
        }
        
        colorLabel.text = cartProd?.colorName
        priceCartLabel.text = cartProd?.price?.replacingOccurrences(of: ".0000", with: "₽")
        nameCartLabel.text = cartProd?.name
        descriptionTextView.text = cartProd?.description
    }
    // Добавление в Realm и корзину
    @IBAction func addToCart(_ sender: Any) {
        if selectedSize == "" {
            let alert = UIAlertController(title: "Упс...", message: "Вы забыли выбрать размер", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Хорошо", style: .cancel, handler: nil)
            alert.addAction(cancel)
            present(alert, animated: true, completion: nil)
        } else {
            let newProd = CartProduct()
            newProd.productName = (cartProd?.name)!
            newProd.productPrice = (cartProd?.price)!
            newProd.productSize = selectedSize
            newProd.productImage = (cartProd?.mainImage)!
            
            try! realm.write {
                self.realm.add(newProd)
            }
            
            let alert = UIAlertController(title: "Товар добавлен", message: "Загляните в корзину, для просмотра добавленных товаров", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Хорошо", style: .cancel, handler: nil)
            alert.addAction(cancel)
            present(alert, animated: true, completion: nil)
            
        }
    }

}

extension ProductCartVC: SizeVCDelegate {
    func get(size: String) {
        selectedSize = size
        print(selectedSize)
    }
    
    
}

extension ProductCartVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cartCV.dequeueReusableCell(withReuseIdentifier: "ProductCartCell", for: indexPath) as! ProductCartCell
        cell.configureCell(content: imageArr[indexPath.item])
        return cell
    }
    
    
}
