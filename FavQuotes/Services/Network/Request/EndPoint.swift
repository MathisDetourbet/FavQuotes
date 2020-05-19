//
//  EndPoint.swift
//  FavQuotes
//
//  Created by Mathis Detourbet on 19/5/20.
//  Copyright © 2020 Mathis Detourbet. All rights reserved.
//

import Foundation

enum EndPoint: CustomStringConvertible {
    case userSession
    case userQuotes(_ userName: String)
    
    var description: String {
        switch self {
        case .userSession:
            return "/session"
            
        case .userQuotes(let userName):
            return "/quotes/?filter=\(userName)&type=user"
        }
    }
}
