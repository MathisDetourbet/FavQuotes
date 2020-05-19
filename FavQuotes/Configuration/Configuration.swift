//
//  Configuration.swift
//  FavQuotes
//
//  Created by Mathis Detourbet on 19/5/20.
//  Copyright © 2020 Mathis Detourbet. All rights reserved.
//

import Foundation
import Alamofire

final class Configuration {
    
    private let host = "https://favqs.com"
    private let apiPath = "/api"
    
    let apiKey = "bc4cba07559aab9baaa480dd418e8e07"
    
    var authToken: String?
    
    var baseApiUrl: String {
        return host + apiPath
    }
}
