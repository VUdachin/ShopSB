//
//  Extensions.swift
//  BS_Shop
//
//  Created by Vladimir Udachin on 01.03.2020.
//  Copyright © 2020 Vladimir Udachin. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func downloadFrom(imageUrl: String) {
        guard let imageUrl = URL(string: imageUrl) else { return }
        URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    self.image = nil
                    print(error)
                }
                  
                guard let response = response as? HTTPURLResponse else {
                    print(DataError.invalidResponse)
                    return
                }
                
                if 200 ... 299 ~= response.statusCode {
                    guard let data = data else { return }
                    self.image = UIImage(data: data)
                    self.layoutSubviews()
                } else {
                    self.image = nil
                    print(DataError.serverError)
                }
            }
        }.resume()
    }
}
