//
//  ProductsListViewController.swift
//  Junto
//
//  Created by Natalia Nikitina on 8/9/17.
//  Copyright © 2017 Natalia Nikitina. All rights reserved.
//

import UIKit
import BTNavigationDropdownMenu

class ProductsListViewController: UIViewController {
    
    @IBOutlet weak var tableViewProducts: UITableView!
    
    var products: [Post] = []
    
    let categories = [Categories.tech.rawValue, Categories.games.rawValue,
                      Categories.podcasts.rawValue, Categories.books.rawValue]
    
    let activityIndicatorInitialLoading = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let menuView = BTNavigationDropdownMenu(title: "tech", items: categories as [AnyObject])
        let font = UIFont(name: "HelveticaNeue", size: 17)
        menuView.navigationBarTitleFont = font
        menuView.cellTextLabelFont = font
        menuView.arrowTintColor = .black
        self.navigationItem.titleView = menuView
        
        menuView.didSelectItemAtIndexHandler = { (indexPath: Int) -> () in
            self.startSpinning()
            ProductsApiManager.shared.getProducts(category: Categories.all[indexPath]) { posts in
                self.products = posts
                self.tableViewProducts.reloadData()
                self.stopSpinning()
            }
        }
        
        tableViewProducts.dataSource = self
        tableViewProducts.delegate = self
        
        tableViewProducts.tableFooterView = UIView()
        
        startSpinning()
        ProductsApiManager.shared.getProducts(category: Categories.tech) { posts in
            self.products = posts
            self.tableViewProducts.reloadData()
            self.stopSpinning()
        }
    }
    
    // MARK: - Spinner
    func startSpinning() {
        tableViewProducts.isHidden = true
        
        activityIndicatorInitialLoading.center = CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height / 2)
        self.view.addSubview(activityIndicatorInitialLoading)
        activityIndicatorInitialLoading.startAnimating()
    }
    
    func stopSpinning() {
        activityIndicatorInitialLoading.stopAnimating()
        activityIndicatorInitialLoading.removeFromSuperview()
        tableViewProducts.isHidden = false
    }

}

// MARK: - UITableViewDataSource
extension ProductsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let product = products[indexPath.row]
        
        let cell = tableViewProducts.dequeue(ProductCell.self)
        cell.imageViewThumbnail.image = #imageLiteral(resourceName: "default_product")
        ImagesManager.shared.loadImage(withURL: product.thumbnailLink, intoImageView: cell.imageViewThumbnail)
        cell.labelName.text = product.name
        cell.labelTagline.text = product.tagline
        cell.labelVotesCount.text = String(product.votesCount)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ProductsListViewController: UITableViewDelegate {
    
}
