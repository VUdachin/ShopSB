//
//  ProductData.swift
//  BS_Shop
//
//  Created by Vladimir Udachin on 02.02.2020.
//  Copyright © 2020 Vladimir Udachin. All rights reserved.
//

import Foundation

// MARK: - ProductValue
struct ProductValue: Codable {
    let name, englishName, sortOrder, article: String?
    let description, colorName, colorImageURL, mainImage: String?
    let productImages: [ProductImage]?
    let offers: [Offer]?
    let recommendedProductIDs: [String]?
    let price: String?
    let tag: String?
    let oldPrice : String?
    let attributes: [Attribute]?

    enum CodingKeys: String, CodingKey {
        case name, englishName, sortOrder, article
        case description, oldPrice
        case colorName, colorImageURL, mainImage, productImages, offers, recommendedProductIDs, price, tag, attributes
    }
}

// MARK: - Attribute
struct Attribute: Codable {
    let picture, season, consist, madeIn: String?
    let decorativeElement: String?

    enum CodingKeys: String, CodingKey {
        case picture = "Рисунок"
        case season = "Сезон"
        case consist = "Состав"
        case madeIn = "Страна производителя"
        case decorativeElement = "Декоративный элемент"
    }
}

// MARK: - Offer
struct Offer: Codable {
    let size, productOfferID: String?
    let quantity: Int?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
    
        size = try container.decode(String.self, forKey: .size)
    
        productOfferID = try container.decode(String.self, forKey: .productOfferID)
    
        if let quantityString = try? container.decode(String.self, forKey: .quantity) {
            quantity = Int(quantityString)!
        } else {
            quantity = try container.decode(Int.self, forKey: .quantity)
        }
    }
}

// MARK: - ProductImage
struct ProductImage: Codable {
    let imageURL, sortOrder: String?
}

typealias Product = [String: ProductValue]
