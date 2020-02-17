//
//  NetworkManager.swift
//  BS_Shop
//
//  Created by Vladimir Udachin on 17.02.2020.
//  Copyright © 2020 Vladimir Udachin. All rights reserved.
//

import Foundation

class NetworkManager {
    
    
    func loadingCategory(completion: @escaping ([Any]) -> Void) {
        guard let url = URL(string: "https://blackstarshop.ru/index.php?route=api/v1/categories") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
        
            guard let data = data else { return }
            
            if error == nil {
                guard let categories = try? JSONDecoder().decode(Category.self, from: data) else { return }
                var cat: [Any] = []
                for v in categories.values {
                    cat.append(v)
                }
                completion(cat)
                
            }
            
        }.resume()
    }
    
    func loadingProduct(id: String, completion: @escaping ([Any]) -> Void) {
        guard let url = URL(string: "https://blackstarshop.ru/index.php?route=api/v1/products&cat_id=\(id)") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else { return }
            
            if error == nil {
                let productJSON = try! JSONDecoder().decode(Product.self, from: data)
                var prod: [Any] = []
                
                DispatchQueue.main.async {
                    if productJSON == nil {
                        print("tut pusto")
                    } else {
                        for v in productJSON.values {
                            prod.append(v)
                        }
                        completion(prod)
                    }
                }
                
                
                
            }
            
            
            
        }.resume()
    }
    
    
    
}
