//
//  UserLoginPost.swift
//  FavQuotes
//
//  Created by Mathis Detourbet on 19/5/20.
//  Copyright © 2020 Mathis Detourbet. All rights reserved.
//

import Foundation

struct UserLoginParameters: Encodable {
    let login: String
    let password: String
}
