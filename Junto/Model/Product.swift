//
//  Product.swift
//  Junto
//
//  Created by Natalia Nikitina on 8/9/17.
//  Copyright © 2017 Natalia Nikitina. All rights reserved.
//

import Foundation

class Product {
    
    var name: String
    var tagline: String
    var votesCount: Int
    var thumbnailURL: String
    var redirectURL: String
    var screenshotURL: String
    
    init(name: String, tagline: String, votesCount: Int, thumbnailURL: String, redirectURL: String, screenshotURL: String) {
        self.name = name
        self.tagline = tagline
        self.votesCount = votesCount
        self.thumbnailURL = thumbnailURL
        self.redirectURL = redirectURL
        self.screenshotURL = screenshotURL
    }
    
}
