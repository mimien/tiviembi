//
//  CurrentTop.swift
//  Tiviembi
//
//  Created by Emilio Cornejo on 10/05/16.
//  Copyright © 2016 Emilio Cornejo. All rights reserved.
//

import Foundation

public class CurrentTop {
    var username: String
    var topIndex: Int
    var get: Top

    init(username: String, topIndex: Int) {
        self.username = username
        self.topIndex = topIndex
        get = Tops.map[username]![topIndex]
    }
}