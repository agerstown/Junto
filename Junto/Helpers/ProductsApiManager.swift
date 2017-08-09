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

enum Categories: String {
    case tech
    case games
    case podcasts
    case books
    
    static let all = [tech, games, podcasts, books]
}

class ProductsApiManager {
    
    static let shared = ProductsApiManager()
    
    let host = "https://api.producthunt.com"
    let token = "591f99547f569b05ba7d8777e2e0824eea16c440292cce1f8dfb3952cc9937ff"
    
    // MARK: - GET methods
    func getProducts(category: Categories, completion: @escaping (_ posts: [Post]) -> Void) {

        let parameters: Parameters = [
            "days_ago": 0
        ]
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
        
        var posts: [Post] = []
        
        Alamofire.request(host + "/v1/categories/" + category.rawValue + "/posts", method: .get, parameters: parameters,
                          headers: headers).responseJSON { response in
            if let value = response.result.value {
                let postsJSON = JSON(value)["posts"]
                for (_, post) in postsJSON {
                    
                    let name = post["name"].stringValue
                    let tagline = post["tagline"].stringValue
                    let votesCount = post["votes_count"].intValue
                    let thumbnailLink = post["thumbnail"]["image_url"].stringValue
                    
                    let postObj = Post(name: name, tagline: tagline, votesCount: votesCount, thumbnailLink: thumbnailLink)
                    posts.append(postObj)
                }
                completion(posts)
            }
        }
    }
    
}
