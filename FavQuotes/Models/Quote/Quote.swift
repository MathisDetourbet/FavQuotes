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
    let dialogue: Bool
    let `private`: Bool
    let tags: [String]
    let url: String
    let favoritesCount: UInt
    let upvotesCount: UInt
    let downvotesCount: UInt
    let author: String
    let authorPermalink: String
    let body: String
}
