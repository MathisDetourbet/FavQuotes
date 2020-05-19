//
//  NetworkLayer.swift
//  FavQuotes
//
//  Created by Mathis Detourbet on 19/5/20.
//  Copyright © 2020 Mathis Detourbet. All rights reserved.
//

import Foundation
import Alamofire

public typealias NetworkCompletionHandler<T: Decodable> = (Result<T, Error>) -> Void

protocol NetworkLayer {
    func sendRequest<T: Decodable, U: Encodable>(with requestProperties: RequestProperties<U>, completionHandler: @escaping NetworkCompletionHandler<T>)
}
