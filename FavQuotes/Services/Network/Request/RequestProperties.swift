//
//  RequestProperties.swift
//  FavQuotes
//
//  Created by Mathis Detourbet on 19/5/20.
//  Copyright © 2020 Mathis Detourbet. All rights reserved.
//

import Foundation

import Alamofire

struct RequestProperties<T: Encodable> {
    let baseUrl: String
    let endPoint: EndPoint
    let method: HTTPMethod
    let headers: HTTPHeaders?
    let parameters: T?
    
    var url: URL? {
        return URL(string: baseUrl + endPoint.description)
    }
}

