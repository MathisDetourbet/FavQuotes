//
//  UserFavQuotesDataAccess.swift
//  FavQuotes
//
//  Created by Mathis Detourbet on 19/5/20.
//  Copyright © 2020 Mathis Detourbet. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

protocol FavQuotesDataAccess {
    func fetchUserFavQuotes(completionHandler: @escaping (Result<[Quote], Error>) -> Void)
    var isLogged: Observable<Bool> { get }
}

final class FavQuotesApiDataAccessor: FavQuotesDataAccess {
    private let configuration: Configuration
    private let networkService: NetworkLayer
    
    init(configuration: Configuration, networkService: NetworkLayer) {
        self.configuration = configuration
        self.networkService = networkService
    }
    
    var isLogged: Observable<Bool> {
        return configuration.userAuthenticationService.isLoggedObs
    }
    
    func fetchUserFavQuotes(completionHandler: @escaping (Result<[Quote], Error>) -> Void) {
        guard let userSession = configuration.userAuthenticationService.userSession else {
            completionHandler(.failure(NetworkError.userNotLoggedIn))
            return
        }
        
        let requestProperties = RequestProperties<UserSession>(baseUrl: configuration.baseApiUrl,
                                                               endPoint: .fetchUserQuotes(userSession.login),
                                                               method: .get,
                                                               headers: buildHeaders(),
                                                               parameters: nil)
        
        networkService.sendRequest(with: requestProperties) { (result: Result<FavQuotesResponse, Error>) in
            switch result {
            case .success(let favQuotesResponse):
                completionHandler(.success(favQuotesResponse.quotes))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    private func buildHeaders() -> HTTPHeaders {
        return [
            "Content-Type": "application/json",
            "Authorization": "Token token=\"\(configuration.apiKey)\""
        ]
    }
}
