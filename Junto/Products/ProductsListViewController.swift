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
    @IBOutlet weak var labelNoProducts: UILabel!
    
    var products: [Product] = []
    
    let categories = [Category.tech.rawValue, Category.games.rawValue,
                      Category.podcasts.rawValue, Category.books.rawValue]
    
    let activityIndicatorInitialLoading = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    let refreshControl = UIRefreshControl()
    
    var selectedCategory: Category = .tech
    
    var selectedProduct: Product?
    
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
            self.selectedCategory = Category.all[indexPath]
            self.startSpinning()
            self.updateProducts(category: self.selectedCategory) {
                self.stopSpinning()
            }
        }
        
        tableViewProducts.dataSource = self
        tableViewProducts.delegate = self
        
        tableViewProducts.tableFooterView = UIView()
        
        refreshControl.addTarget(self, action: #selector(handleRefresh(refreshControl:)), for: UIControlEvents.valueChanged)
        tableViewProducts.refreshControl = refreshControl
        
        startSpinning()
        updateProducts(category: Category.tech) {
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

    // MARK: - Data updates
    func updateProducts(category: Category, completion: @escaping () -> Void) {
        self.labelNoProducts.isHidden = true
        ProductsApiManager.shared.getProducts(category: category) { products in
            self.products = products
            if products.count > 0 {
                self.tableViewProducts.isHidden = false
            } else {
                self.labelNoProducts.isHidden = false
                self.tableViewProducts.isHidden = true
                self.labelNoProducts.text = "No " + self.selectedCategory.rawValue + " for today :("
            }
            self.tableViewProducts.reloadData()
            completion()
        }
    }
    
    func handleRefresh(refreshControl: UIRefreshControl) {
        updateProducts(category: selectedCategory) {
            refreshControl.endRefreshing()
        }
    }
    
    // MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? ProductViewController {
            controller.product = selectedProduct
        }
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
        ImagesManager.shared.loadImage(withURL: product.thumbnailURL, intoImageView: cell.imageViewThumbnail)
        cell.labelName.text = product.name
        cell.labelTagline.text = product.tagline
        cell.labelVotesCount.text = String(product.votesCount)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ProductsListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedProduct = products[indexPath.row]
        performSegue(withIdentifier: "segueToProductViewController", sender: nil)
        tableViewProducts.deselectRow(at: indexPath, animated: false)
    }
    
}
