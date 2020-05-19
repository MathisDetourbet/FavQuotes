//
//  UserFavQuotesViewModel.swift
//  FavQuotes
//
//  Created by Mathis Detourbet on 19/5/20.
//  Copyright © 2020 Mathis Detourbet. All rights reserved.
//

import Foundation

final class UserFavQuotesViewModel: TableViewModel {
    internal var model: [QuoteViewModel]
    
    init() {
        self.model = []
    }
    
    private func fetchUserFavQuotes() {
        
    }
}
