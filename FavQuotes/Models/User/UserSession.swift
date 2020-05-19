//
//  UserSession.swift
//  FavQuotes
//
//  Created by Mathis Detourbet on 19/5/20.
//  Copyright © 2020 Mathis Detourbet. All rights reserved.
//

import Foundation

struct UserSession {
    let userToken: String
    let login: String
    let email: String
}

extension UserSession: Decodable {
    
    enum UserSessionCodingKeys: String, CodingKey {
        case userToken = "User-Token"
        case login
        case email
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: UserSessionCodingKeys.self)
        
        userToken = try container.decode(String.self, forKey: .userToken)
        login = try container.decode(String.self, forKey: .login)
        email = try container.decode(String.self, forKey: .email)
    }
}
