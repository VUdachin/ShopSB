//
//  NetworkManager.swift
//  BS_Shop
//
//  Created by Vladimir Udachin on 17.02.2020.
//  Copyright © 2020 Vladimir Udachin. All rights reserved.
//

import Foundation

let mainURL = "https://blackstarshop.ru/"
let categoryURL = URL(string: "https://blackstarshop.ru/index.php?route=api/v1/categories")
let productURL = "https://blackstarshop.ru/index.php?route=api/v1/products&cat_id="

enum DataError: Error {
    case invalidResponse
    case invalidData
    case decodingError
    case serverError
}

class JSONParser {
    
    typealias result<T> = (Result<T, Error>) -> Void
    
    func downloadData<T: Decodable>(of type: T.Type, from url: URL, completion: @escaping result<T>) {
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(DataError.invalidResponse))
                return
            }
            
            if 200 ... 299 ~= response.statusCode {
                if let data = data {
                    do {
                        let decodedData: T = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(decodedData))
                    }
                    catch {
                        completion(.failure(DataError.decodingError))
                    }
                } else {
                    completion(.failure(DataError.invalidData))
                }
            } else {
                completion(.failure(DataError.serverError))
            }
        }.resume()
    }
}
