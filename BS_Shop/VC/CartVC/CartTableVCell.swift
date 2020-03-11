//
//  CartTableVC.swift
//  BS_Shop
//
//  Created by Vladimir Udachin on 13.02.2020.
//  Copyright © 2020 Vladimir Udachin. All rights reserved.
//

import UIKit
import RealmSwift

class CartTableVCell: UITableViewCell {

    private lazy var realm = try! Realm()
    
    @IBOutlet weak var cartImageView: UIImageView!
    
    @IBOutlet weak var cartNameLabel: UILabel!
    @IBOutlet weak var cartCostLabel: UILabel!
    @IBOutlet weak var cartSizeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCell(content: CartProduct) {
        cartImageView.downloadFrom(imageUrl: mainURL + content.productImage)
        cartNameLabel.text = content.productName
        cartCostLabel.text = "Стоимость: \(content.productPrice.replacingOccurrences(of: ".0000", with: "₽"))"
        cartSizeLabel.text = "Размер: \(content.productSize)"
    }
}
