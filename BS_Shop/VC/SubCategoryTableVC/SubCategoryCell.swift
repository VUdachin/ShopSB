//
//  SubCategoryCell.swift
//  BS_Shop
//
//  Created by Vladimir Udachin on 31.01.2020.
//  Copyright © 2020 Vladimir Udachin. All rights reserved.
//

import UIKit

class SubCategoryCell: UITableViewCell {

    @IBOutlet weak var subCategoryIconImageView: UIImageView!
    @IBOutlet weak var subCategoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
