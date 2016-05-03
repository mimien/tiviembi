//
//  Top.swift
//  Tiviembi
//
//  Created by Emilio Cornejo on 02/05/16.
//  Copyright © 2016 Emilio Cornejo. All rights reserved.
//

import Foundation

class Top {
    var name: String
    var categories: (Bool, Bool, Bool, Bool) // movies, tv shows, videogames, books
    var list: [String]
    
    init(name: String, categories: (Bool, Bool, Bool, Bool), list: [String]) {
        self.name = name
        self.categories = categories
        self.list = list
    }
    
    var description: String {
        return "Top \(list.count) \(name)"
    }
    
    func icons() -> String {
        var string: String = ""
        if categories.0 {
            string += "🎬"
        }
        if categories.1 {
            string += "📺"
        }
        if categories.2 {
            string += "🎮"
        }
        if categories.3 {
            string += "📚"
        }
        return string
    }
}