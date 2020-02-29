//
//  ProductCollectionVC.swift
//  BS_Shop
//
//  Created by Vladimir Udachin on 01.02.2020.
//  Copyright © 2020 Vladimir Udachin. All rights reserved.
//

import UIKit



class ProductVC: UIViewController {
    
    @IBOutlet weak var productCV: UICollectionView!
    
    var subCategoryId: String = ""
    
    var products: [ProductValue] = []
    
    var selectedProduct: ProductValue?
    
    let networkManager = NetworkManager()
    let jsonParser = JSONParser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ProductCartVC, segue.identifier == "ShowProductCart" {
            vc.cartProd = selectedProduct
        }
    }
    private func loadData() {
        jsonParser.downloadData(of: Product.self, from: URL(string: "\(productURL + subCategoryId)")!) { (result) in
            switch result {
            case .failure(let error):
                if error is DataError {
                    print(error)
                } else {
                    print(error.localizedDescription)
                }
                print(error.localizedDescription)
                
            case .success(let result):
                DispatchQueue.main.async {
                    var prod: [ProductValue] = []
                    
                    if result == nil {
                        print("tut pusto")
                    } else {
                        for v in result.values {
                            prod.append(v)
                        }
                    }
                    
                    self.products = prod
                
                    self.productCV.reloadData()
                }
            }
        }
    }
}
    
    extension ProductVC: UICollectionViewDataSource, UICollectionViewDelegate {
        
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
        }


        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of items
            return products.count
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell
            if products.count == 0 {
                return cell
            } else {
                let product = products[indexPath.item]
                
                let imageUrl = URL(string: "https://blackstarshop.ru/\(product.mainImage!)")
                cell.productImageView.image = UIImage(data: try! Data(contentsOf: imageUrl!))
                
                cell.priceLabel.text = product.price!.replacingOccurrences(of: ".0000", with: "₽")
                if product.oldPrice != nil {
                    cell.oldPriceLabel.text = "Старая цена: \(product.oldPrice!.replacingOccurrences(of: ".0000", with: "₽"))"
                } else {
                    cell.oldPriceLabel.text = product.oldPrice
                }
                
                cell.productNameLabel.text = product.name
                
                return cell
            }
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let product = products[indexPath.item]
            selectedProduct = product
            performSegue(withIdentifier: "ShowProductCart", sender: self)
        }
        
}

    
        
        
        
        
        
        
 
