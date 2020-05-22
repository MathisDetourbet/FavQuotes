//
//  Quote.swift
//  FavQuotes
//
//  Created by Mathis Detourbet on 19/5/20.
//  Copyright © 2020 Mathis Detourbet. All rights reserved.
//

import Foundation

final class Quote: NSObject, Decodable {
    let id: Int
    let dialogue: Bool
    let `private`: Bool
    let tags: [String]
    let url: String
    let favoritesCount: Int
    let upvotesCount: Int
    let downvotesCount: Int
    let author: String
    let authorPermalink: String
    let body: String
    
    init(id: Int, dialogue: Bool, privateBool: Bool, tags: [String], url: String, favoritesCount: Int, upvotesCount: Int, downvotesCount: Int, author: String, authorPermalink: String, body: String) {
        self.id = id
        self.dialogue = dialogue
        self.private = privateBool
        self.tags = tags
        self.url = url
        self.favoritesCount = favoritesCount
        self.upvotesCount = upvotesCount
        self.downvotesCount = downvotesCount
        self.author = author
        self.authorPermalink = authorPermalink
        self.body = body
    }
}

extension Quote: NSCoding {
    
    enum QuoteKeys: String {
        case id, dialogue, tags, url, favoritesCount, upvotesCount, downvotesCount, author, authorPermalink, body
        case privateBool = "private"
    }
    
    convenience init?(coder: NSCoder) {
        let id = coder.decodeInteger(forKey: QuoteKeys.id.rawValue)
        let dialogue = coder.decodeBool(forKey: QuoteKeys.dialogue.rawValue)
        let privateBool = coder.decodeBool(forKey: QuoteKeys.privateBool.rawValue)
        let tags = coder.decodeObject(forKey: QuoteKeys.tags.rawValue) as? [String] ?? []
        let url = coder.decodeObject(forKey: QuoteKeys.url.rawValue) as? String ?? ""
        let favoritesCount = coder.decodeInteger(forKey: QuoteKeys.favoritesCount.rawValue)
        let upvotesCount = coder.decodeInteger(forKey: QuoteKeys.upvotesCount.rawValue)
        let downvotesCount = coder.decodeInteger(forKey: QuoteKeys.downvotesCount.rawValue)
        let author = coder.decodeObject(forKey: QuoteKeys.author.rawValue) as? String ?? ""
        let authorPermalink = coder.decodeObject(forKey: QuoteKeys.authorPermalink.rawValue) as? String ?? ""
        let body = coder.decodeObject(forKey: QuoteKeys.body.rawValue) as? String ?? ""

        self.init(id: id, dialogue: dialogue, privateBool: privateBool, tags: tags, url: url, favoritesCount: favoritesCount, upvotesCount: upvotesCount, downvotesCount: downvotesCount, author: author, authorPermalink: authorPermalink, body: body)
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(id, forKey: QuoteKeys.id.rawValue)//.encode(id, forKey: QuoteKeys.id.rawValue)
        coder.encode(dialogue, forKey: QuoteKeys.dialogue.rawValue)
        coder.encode(self.private, forKey: QuoteKeys.privateBool.rawValue)
        coder.encode(tags, forKey: QuoteKeys.tags.rawValue)
        coder.encode(url, forKey: QuoteKeys.url.rawValue)
        coder.encode(favoritesCount, forKey: QuoteKeys.favoritesCount.rawValue)
        coder.encode(upvotesCount, forKey: QuoteKeys.upvotesCount.rawValue)
        coder.encode(downvotesCount, forKey: QuoteKeys.downvotesCount.rawValue)
        coder.encode(author, forKey: QuoteKeys.author.rawValue)
        coder.encode(authorPermalink, forKey: QuoteKeys.authorPermalink.rawValue)
        coder.encode(body, forKey: QuoteKeys.body.rawValue)
    }
}
