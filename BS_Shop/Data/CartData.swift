//
//  CartData.swift
//  BS_Shop
//
//  Created by Vladimir Udachin on 13.02.2020.
//  Copyright © 2020 Vladimir Udachin. All rights reserved.
//

import Foundation
import RealmSwift

class CartProduct: Object {
    
    @objc dynamic var productName = ""
    @objc dynamic var productPrice = ""
    @objc dynamic var productSize = ""
    @objc dynamic var productImage = ""
}
