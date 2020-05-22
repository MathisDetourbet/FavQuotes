//
//  FavQuotesResponse.swift
//  FavQuotes
//
//  Created by Mathis Detourbet on 22/5/20.
//  Copyright © 2020 Mathis Detourbet. All rights reserved.
//

import Foundation

struct FavQuotesResponse: Decodable {
    let quotes: [Quote]
}
