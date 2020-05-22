//
//  LoginDataAccess.swift
//  FavQuotes
//
//  Created by Mathis Detourbet on 19/5/20.
//  Copyright © 2020 Mathis Detourbet. All rights reserved.
//

import Foundation
import Alamofire

protocol LoginDataAccess {
    func fetchUserSession(login: String, password: String, completionHandler: @escaping (Error?) -> Void)
}

final class LoginDataAccessor: LoginDataAccess {
    private let configuration: Configuration
    private let networkService: NetworkLayer
    
    init(configuration: Configuration, networkService: NetworkLayer) {
        self.configuration = configuration
        self.networkService = networkService
    }
    
    func fetchUserSession(login: String, password: String, completionHandler: @escaping (Error?) -> Void) {
        let requestProperties = RequestProperties<[String: UserLoginParameters]>(baseUrl: configuration.baseApiUrl,
                                                  endPoint: .fetchUserSession,
                                                  method: .post,
                                                  headers: buildPublicRequestHeaders(),
                                                  parameters: buildUserLoginParameters(with: login, and: password))
        
        networkService.sendRequest(with: requestProperties) { [weak self] (result: Result<UserSession, Error>) in
            switch result {
            case .success(let userSession):
                self?.configuration.userAuthenticationService.userSession = userSession
                
                self?.fetchUser { error in
                    completionHandler(error)
                }
                
            case .failure(let error):
                completionHandler(error)
            }
        }
    }
    
    private func fetchUser(completionHandler: @escaping (Error?) -> Void) {
        guard let userName = configuration.userAuthenticationService.userSession?.login else {
            completionHandler(NetworkError.userNotLoggedIn)
            return
        }
        
        let requestProperties = RequestProperties<User>(baseUrl: configuration.baseApiUrl,
                                                        endPoint: .fetchUser(userName),
                                                        method: .get,
                                                        headers: buildPrivateRequestHeaders(),
                                                        parameters: nil)
        
        networkService.sendRequest(with: requestProperties) { [weak self] (result: Result<User, Error>) in
            switch result {
            case .success(let user):
                self?.configuration.userAuthenticationService.user = user
                completionHandler(nil)
                
            case .failure(let error):
                completionHandler(error)
            }
        }
    }
    
    private func buildPublicRequestHeaders() -> HTTPHeaders {
        return [
            "Content-Type": "application/json",
            "Authorization": "Token token=\"\(configuration.apiKey)\""
        ]
    }
    
    private func buildPrivateRequestHeaders() -> HTTPHeaders {
        return [
            "Content-Type": "application/json",
            "Authorization": "Token token=\"\(configuration.apiKey)\"",
            "User-Token": configuration.userAuthenticationService.userSession?.userToken ?? ""
        ]
    }
    
    private func buildUserLoginParameters(with login: String, and password: String) -> [String: UserLoginParameters] {
        return [
            "user": UserLoginParameters(login: login, password: password)
        ]
    }
}
