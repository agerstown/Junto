//
//  ProductsApiManager.swift
//  Junto
//
//  Created by Natalia Nikitina on 8/9/17.
//  Copyright © 2017 Natalia Nikitina. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ProductsApiManager {
    
    static let shared = ProductsApiManager()
    
    private let host = "https://api.producthunt.com"
    private let token = "591f99547f569b05ba7d8777e2e0824eea16c440292cce1f8dfb3952cc9937ff"
    
    // MARK: - GET methods
    func getProducts(category: Category, completion: @escaping (_ products: [Product]) -> Void) {

        let parameters: Parameters = [
            "days_ago": 0
        ]
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
        
        var products: [Product] = []
        
        Alamofire.request(host + "/v1/categories/" + category.rawValue + "/posts", method: .get, parameters: parameters,
                          headers: headers).responseJSON { response in
            guard let value = response.result.value else { return }
            let posts = JSON(value)["posts"]
            for (_, post) in posts {
                
                let name = post["name"].stringValue
                let tagline = post["tagline"].stringValue
                let votesCount = post["votes_count"].intValue
                let thumbnailURL = post["thumbnail"]["image_url"].stringValue
                let redirectURL = post["redirect_url"].stringValue
                print(post["screenshot_url"])
                let screenshotURL = post["screenshot_url"]["300px"].stringValue
                
                let product = Product(name: name, tagline: tagline, votesCount: votesCount,
                                   thumbnailURL: thumbnailURL, redirectURL: redirectURL, screenshotURL: screenshotURL)
                products.append(product)
            }
            completion(products)
        }
    }
    
}
