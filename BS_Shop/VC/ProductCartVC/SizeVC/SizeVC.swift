//
//  SizeVC.swift
//  BS_Shop
//
//  Created by Vladimir Udachin on 11.02.2020.
//  Copyright © 2020 Vladimir Udachin. All rights reserved.
//

import UIKit

protocol SizeVCDelegate {
    func get(size: String)
}

class SizeVC: UIViewController {

    var delegate: SizeVCDelegate?
    
    var sizes: [Offer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(sizes)
    }
    
}

extension SizeVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sizes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "changeSizeCell", for: indexPath) as! SizeTableVCell
        
        cell.sizeLabel.text = sizes[indexPath.row].size
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sz = sizes[indexPath.row].size!
        delegate?.get(size: sz)
        dismiss(animated: true, completion: nil)
    }
    
}
