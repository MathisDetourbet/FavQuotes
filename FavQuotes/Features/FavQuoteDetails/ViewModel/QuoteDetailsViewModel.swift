//
//  FavQuoteDetailsViewModel.swift
//  FavQuotes
//
//  Created by Mathis Detourbet on 22/5/20.
//  Copyright © 2020 Mathis Detourbet. All rights reserved.
//

import Foundation

final class QuoteDetailsViewModel: FavQuotesPresenter {
    private let model: Quote
    
    public var idString: String { return "ID: \(model.id)" }
    public var dialogueString: String { return "Is dialogue \(model.dialogue ? "YES" : "NO")" }
    public var privateString: String { return "Is private: \(model.dialogue ? "YES" : "NO")" }
    public var tagsString: String { return "Tags: \(model.tags.joined(separator: ", "))" }
    public var urlStrigng: String { return "Url: \(model.url)" }
    public var favoritesCountString: String { return "Favorites count: \(model.favoritesCount)" }
    public var upVotesCountString: String { return "Up votes count: \(model.upvotesCount)" }
    public var downVotesCountString: String { return "Down votes count \(model.downvotesCount)" }
    public var authorString: String { return "Author: \(model.author)" }
    public var authorPermaLinkString: String { "Author permalink: \(model.authorPermalink)" }
    public var bodyString: String { return "Body: \(model.body)" }
    
    init(model: Quote) {
        self.model = model
    }
}
