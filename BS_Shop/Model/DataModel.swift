//
//  Data.swift
//  BS_Shop
//
//  Created by Vladimir Udachin on 31.01.2020.
//  Copyright © 2020 Vladimir Udachin. All rights reserved.
//

import Foundation

// MARK: - Category
struct CategoryValue: Codable {
    let name, iconImage: String
    let sortOrder: Int
    let subcategories: [Subcategory]

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try container.decode(String.self, forKey: .name)
        
        iconImage = try container.decode(String.self, forKey: .iconImage)
        
        if let sortOrderString = try? container.decode(String.self, forKey: .sortOrder) {
            sortOrder = Int(sortOrderString)!
        } else {
            sortOrder = try container.decode(Int.self, forKey: .sortOrder)
        }
        
        subcategories = try container.decode([Subcategory].self, forKey: .subcategories)
    }
    
    private enum CodingKeys: String, CodingKey {
           case name
           case iconImage
           case sortOrder
           case subcategories
       }
}

struct Subcategory: Codable {
    let id: String
    let iconImage: String
    let sortOrder: Int
    let name: String
    let type: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        
        if let idInt = try? container.decode(Int.self, forKey: .id) {
            id = "\(idInt)"
        } else {
            id = try container.decode(String.self, forKey: .id)
        }
        
        iconImage = try container.decode(String.self, forKey: .iconImage)
        
        if let sortOrderString = try? container.decode(String.self, forKey: .sortOrder) {
            sortOrder = Int(sortOrderString)!
        } else {
            sortOrder = try container.decode(Int.self, forKey: .sortOrder)
        }
        
        name = try container.decode(String.self, forKey: .name)
        
        type = try! container.decode(String.self, forKey: .type)
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case iconImage
        case sortOrder
        case name
        case type
    }

    
}

typealias Category = [String: CategoryValue]
