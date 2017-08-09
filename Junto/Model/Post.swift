//
//  Post.swift
//  Junto
//
//  Created by Natalia Nikitina on 8/9/17.
//  Copyright © 2017 Natalia Nikitina. All rights reserved.
//

import Foundation

class Post {
    
    var name: String
    var tagline: String
    var votesCount: Int
    var thumbnailLink: String
    
    init(name: String, tagline: String, votesCount: Int, thumbnailLink: String) {
        self.name = name
        self.tagline = tagline
        self.votesCount = votesCount
        self.thumbnailLink = thumbnailLink
    }
    
}
