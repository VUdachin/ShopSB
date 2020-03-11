//
//  ProductCell.swift
//  BS_Shop
//
//  Created by Vladimir Udachin on 01.02.2020.
//  Copyright © 2020 Vladimir Udachin. All rights reserved.
//

import UIKit

class ProductCell: UICollectionViewCell {
    
    @IBOutlet weak var productImageView: UIImageView!
    
    @IBOutlet weak var oldPriceLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    

    func configureCell(content: ProductValue) {
        productImageView.downloadFrom(imageUrl: mainURL + content.mainImage!)
        
        if content.oldPrice != nil {
            oldPriceLabel.text = "Старая цена: \(content.oldPrice!.replacingOccurrences(of: ".0000", with: "₽"))"
        } else {
            oldPriceLabel.text = content.oldPrice
        }
        
        priceLabel.text = content.price!.replacingOccurrences(of: ".0000", with: "₽")
        productNameLabel.text = content.name
    }
}
