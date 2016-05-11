//
//  Top.swift
//  Tiviembi
//
//  Created by Emilio Cornejo on 02/05/16.
//  Copyright © 2016 Emilio Cornejo. All rights reserved.
//

import Foundation

class Top {
    enum Category: String {
        case movies = "🎬 Movies"
        case tv = "📺 TV Shows"
        case videogames = "🎮 Videogames"
        case books = "📚 Books"
        case sports = "⚽️ Sports"
        case food = "🍔 Food"
        
        static let allValues = [movies, tv, videogames, books, sports, food]
    }
    var name: String
    var category: Category // movies, tv shows, videogames, books
    var list: [String]
    
    init(name: String, category: Category, list: [String]) {
        self.name = name
        self.category = category
        self.list = list
    }
    
    var description: String {
        return "Top \(list.count) \(name)"
    }
    
    func categoryStr() -> String {
        return "\(icon()) \(category)"
    }
    
    func icon() -> String {
        switch category {
        case .movies:
            return "🎬"
        case .tv:
            return "📺"
        case .videogames:
            return "🎮"
        case .books:
            return "📚"
        case .sports:
            return "⚽️"
        case .food:
            return "🍔"
        }
    }
}