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
    
    let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingData()
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
    
    private func loadingData() {
        networkManager.loadingCategory { (cat) in
            
            self.loadedCategories = cat as! [CategoryValue]
            
            self.loadedCategories.sort { (elem1, elem2) -> Bool in
            return elem1.sortOrder < elem2.sortOrder
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
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
