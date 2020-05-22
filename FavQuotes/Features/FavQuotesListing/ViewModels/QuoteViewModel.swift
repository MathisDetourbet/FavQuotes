//
//  QuoteViewModel.swift
//  FavQuotes
//
//  Created by Mathis Detourbet on 19/5/20.
//  Copyright © 2020 Mathis Detourbet. All rights reserved.
//

import Foundation

final class QuoteViewModel: FavQuotesPresenter {
    let model: Quote
    
    var authorString: String {
        return model.author
    }
    
    var bodyString: String {
        return model.body
    }
    
    init(model: Quote) {
        self.model = model
    }
    
    func instantiateQuoteDetailsViewModel() -> QuoteDetailsViewModel {
        return QuoteDetailsViewModel(model: model)
    }
}
