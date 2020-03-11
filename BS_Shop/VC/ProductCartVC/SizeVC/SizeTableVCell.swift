//
//  SizeTableVC.swift
//  BS_Shop
//
//  Created by Vladimir Udachin on 11.02.2020.
//  Copyright © 2020 Vladimir Udachin. All rights reserved.
//

import UIKit

class SizeTableVCell: UITableViewCell {

    @IBOutlet weak var sizeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCell(content: Offer) {
        sizeLabel.text = content.size
    }
}
