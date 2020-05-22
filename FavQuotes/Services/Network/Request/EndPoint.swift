//
//  EndPoint.swift
//  FavQuotes
//
//  Created by Mathis Detourbet on 19/5/20.
//  Copyright © 2020 Mathis Detourbet. All rights reserved.
//

import Foundation

enum EndPoint: CustomStringConvertible {
    case fetchUserSession
    case fetchUser(_ userName: String)
    case fetchUserQuotes(_ userName: String)
    
    var description: String {
        switch self {
        case .fetchUserSession:
            return "/session"
            
        case .fetchUser(let userName):
            return "/users/\(userName)"
            
        case .fetchUserQuotes(let userName):
            return "/quotes/?filter=\(userName)&type=user"
        }
    }
}
