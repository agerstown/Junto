//
//  ProductsListViewController.swift
//  Junto
//
//  Created by Natalia Nikitina on 8/9/17.
//  Copyright © 2017 Natalia Nikitina. All rights reserved.
//

import UIKit

class ProductsListViewController: UIViewController {
    
    @IBOutlet weak var tableViewProducts: UITableView!
    
    var products: [Post] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewProducts.dataSource = self
        tableViewProducts.delegate = self
        
        ProductsApiManager.shared.getProducts(category: Categories.tech) { posts in
            self.products = posts
            self.tableViewProducts.reloadData()
        }
    }
    
}

extension ProductsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let product = products[indexPath.row]
        
        let cell = tableViewProducts.dequeue(ProductCell.self)
        cell.labelName.text = product.name
        cell.labelTagline.text = product.tagline
        cell.labelVotesCount.text = String(product.votesCount)
        
        return cell
    }
}

extension ProductsListViewController: UITableViewDelegate {
    
}
