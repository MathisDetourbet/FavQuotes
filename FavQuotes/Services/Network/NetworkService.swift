//
//  NetworkService.swift
//  FavQuotes
//
//  Created by Mathis Detourbet on 19/5/20.
//  Copyright © 2020 Mathis Detourbet. All rights reserved.
//

import Foundation
import Alamofire

final class NetworkService: NetworkLayer {

    func sendRequest<T: Decodable, U: Encodable>(with requestProperties: RequestProperties<U>, completionHandler: @escaping NetworkCompletionHandler<T>) {
        guard let url = requestProperties.url else {
            completionHandler(.failure(NetworkError.badUrl))
            return
        }
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        AF
            .request(url,
                     method: requestProperties.method,
                     parameters: requestProperties.parameters,
                     encoder: JSONParameterEncoder.default,
                     headers: requestProperties.headers)
            
            .validate()
            .responseDecodable(of: T.self, decoder: jsonDecoder) { response in
                switch response.result {
                case .success(let decodedObject):
                    completionHandler(.success(decodedObject))
                    break
                
                case .failure(let afError):
                    completionHandler(.failure(afError))
                    break
                }
        }
    }
}
