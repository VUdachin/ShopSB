//
//  SubCategoryTableVCTableViewController.swift
//  BS_Shop
//
//  Created by Vladimir Udachin on 31.01.2020.
//  Copyright © 2020 Vladimir Udachin. All rights reserved.
//

import UIKit

class SubCategoryTableVC: UITableViewController {

    var loadedSubCategories: [Subcategory] = []
    
    var categoryId: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ProductVC, segue.identifier == "ShowProduct" {
            vc.subCategoryId = categoryId
        }
    }
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loadedSubCategories.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubCategoryCell", for: indexPath) as! SubCategoryCell
        let subcategory = loadedSubCategories[indexPath.row]
        cell.configureCell(content: subcategory)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let subcategory = loadedSubCategories[indexPath.row]
        self.categoryId = subcategory.id
        performSegue(withIdentifier: "ShowProduct", sender: self)
    }
}
