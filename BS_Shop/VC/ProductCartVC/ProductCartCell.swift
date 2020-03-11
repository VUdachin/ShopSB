//
//  ProductCartCell.swift
//  BS_Shop
//
//  Created by Vladimir Udachin on 07.02.2020.
//  Copyright © 2020 Vladimir Udachin. All rights reserved.
//

import UIKit

class ProductCartCell: UICollectionViewCell {
    
    @IBOutlet weak var cartImageView: UIImageView!
    
    func configureCell(content: String) {
        cartImageView.downloadFrom(imageUrl: mainURL + content)
    }

}
