//
//  Quote.swift
//  FavQuotes
//
//  Created by Mathis Detourbet on 19/5/20.
//  Copyright © 2020 Mathis Detourbet. All rights reserved.
//

import Foundation

struct Quote: Decodable {
    let id: UInt
    let author: String
    let body: String
}
