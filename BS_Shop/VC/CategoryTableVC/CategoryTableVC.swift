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
    
    let jsonParser = JSONParser()
    
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
        
        jsonParser.downloadData(of: Category.self, from: categoryURL!) { (result) in
            switch result {
            case .failure(let error):
                if error is DataError {
                    print(error)
                } else {
                    print(error.localizedDescription)
                }
                print(error.localizedDescription)
                
            case .success(let result):
                DispatchQueue.main.async {
                    var categories: [CategoryValue] = []
                    for v in result.values {
                        categories.append(v)
                    }
                    
                    self.loadedCategories = categories
                    
                    self.loadedCategories.sort { (elem1, elem2) -> Bool in
                    return elem1.sortOrder < elem2.sortOrder
                    }
                    self.tableView.reloadData()
                }
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
        cell.configureCell(content: category)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let subCategory = loadedCategories[indexPath.row].subcategories
        self.selectedSubcategories = subCategory
        performSegue(withIdentifier: "ShowSubcategory", sender: self)
    }
}
