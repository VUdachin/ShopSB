//
//  CategoryCell.swift
//  BS_Shop
//
//  Created by Vladimir Udachin on 31.01.2020.
//  Copyright © 2020 Vladimir Udachin. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {
    
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCell(content: CategoryValue) {
        categoryNameLabel.text = content.name
        iconImageView.downloadFrom(imageUrl: mainURL + content.iconImage)
        
    }
    
}
