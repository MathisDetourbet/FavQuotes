//
//  User.swift
//  FavQuotes
//
//  Created by Mathis Detourbet on 19/5/20.
//  Copyright © 2020 Mathis Detourbet. All rights reserved.
//

import Foundation

struct User: Codable {
    let login: String
    let picUrl: String
    let publicFavoritesCount: UInt
}
