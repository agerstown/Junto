//
//  ProductViewController.swift
//  Junto
//
//  Created by Natalia Nikitina on 8/9/17.
//  Copyright © 2017 Natalia Nikitina. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var imageViewScreenshot: UIImageView!
    @IBOutlet weak var labelTagline: UILabel!
    @IBOutlet weak var labelVotesCount: UILabel!
    @IBOutlet weak var buttonGetIt: UIButton!
    
    var product: Product?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let product = product {
            labelName.text = product.name
            labelTagline.text = product.tagline
            labelVotesCount.text = String(product.votesCount)
            imageViewScreenshot.image = #imageLiteral(resourceName: "default_product")
            ImagesManager.shared.loadImage(withURL: product.screenshotURL, intoImageView: imageViewScreenshot)
        }
        
        buttonGetIt.layer.cornerRadius = 5
    }
    
    // MARK: - Actions
    @IBAction func buttonGetItTapped(_ sender: Any) {
        if let product = product {
            if let url = URL(string: product.redirectURL) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
}
