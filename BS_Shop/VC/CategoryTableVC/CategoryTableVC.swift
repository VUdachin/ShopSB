//
//  ViewController.swift
//  BS_Shop
//
//  Created by Vladimir Udachin on 31.01.2020.
//  Copyright © 2020 Vladimir Udachin. All rights reserved.
//

import UIKit

class CategoryTableVC: UITableViewController {

    var loadedCategories: [CategoryValue] = []

    var selectedSubcategories: [Subcategory] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingCategory()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? SubCategoryTableVC, segue.identifier == "ShowSubcategory" {
            //Передаем только категории
            for value in selectedSubcategories {
                if value.type == "Category" {
                    vc.loadedSubCategories.append(value)
                }
            }
        }
    }
    
    
    
    func loadingCategory() {
        guard let url = URL(string: "https://blackstarshop.ru/index.php?route=api/v1/categories") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else { return }
            
            do{
                let categories = try? JSONDecoder().decode(Category.self, from: data)
                
                for v in categories!.values {
                    self.loadedCategories.append(v)
                }
                
                self.loadedCategories.sort { (elem1, elem2) -> Bool in
                return elem1.sortOrder < elem2.sortOrder
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print(error)
            }
        }.resume()
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        loadedCategories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        let category = loadedCategories[indexPath.row]

        cell.categoryNameLabel.text = category.name
        
        let imageUrl = URL(string: "https://blackstarshop.ru/\(category.iconImage)")
        cell.iconImageView.image = UIImage(data: try! Data(contentsOf: imageUrl!))
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let subCategory = loadedCategories[indexPath.row].subcategories
        self.selectedSubcategories = subCategory
        performSegue(withIdentifier: "ShowSubcategory", sender: self)
    }
}
