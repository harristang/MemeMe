//
//  Meme.swift
//  MemeMe
//
//  Created by Harris Tang on 9/27/15.
//  Copyright © 2015 Harris Tang. All rights reserved.
//

import Foundation
import UIKit

struct Meme {
    var topMemeText: String!
    var bottomMemeText: String!
    var memeImage: UIImage!
    var memeImageWithText: UIImage!
    
    func memeTitle() -> String {
        let topString:String!
        if (topMemeText.characters.count < 10) {
            topString = topMemeText
        } else {
            topString = topMemeText.substringToIndex(topMemeText.startIndex.advancedBy(10))
        }
        
        let bottomString:String!
        if (bottomMemeText.characters.count < 10) {
            bottomString = bottomMemeText
        } else {
            bottomString = bottomMemeText.substringToIndex(bottomMemeText.startIndex.advancedBy(10))
        }
        
        return "\(topString)...\(bottomString)"
    }
}