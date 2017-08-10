//
//  Product.swift
//  Junto
//
//  Created by Natalia Nikitina on 8/9/17.
//  Copyright © 2017 Natalia Nikitina. All rights reserved.
//

import Foundation

enum Category: String {
    case tech
    case games
    case podcasts
    case books
    
    static let all = [tech, games, podcasts, books]
}

class Product {
    
    let name: String
    let tagline: String
    let votesCount: Int
    let thumbnailURL: String
    let redirectURL: String
    let screenshotURL: String
    
    init(name: String, tagline: String, votesCount: Int, thumbnailURL: String, redirectURL: String, screenshotURL: String) {
        self.name = name
        self.tagline = tagline
        self.votesCount = votesCount
        self.thumbnailURL = thumbnailURL
        self.redirectURL = redirectURL
        self.screenshotURL = screenshotURL
    }
    
}
