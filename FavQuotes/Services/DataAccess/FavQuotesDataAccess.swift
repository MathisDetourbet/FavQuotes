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
    private let localStorageService = LocalStorageService()
    private let disposeBag = DisposeBag()
    
    init(configuration: Configuration, networkService: NetworkLayer) {
        self.configuration = configuration
        self.networkService = networkService
    }
    
    var isLogged: Observable<Bool> {
        return configuration.userAuthenticationService.isLoggedObs
    }
    
    func fetchUserFavQuotes(completionHandler: @escaping (Result<[Quote], Error>) -> Void) {
        guard let userSession = configuration.userAuthenticationService.userSession else {
            localStorageService.fetchQuotesIfAvailable().subscribe(onSuccess: { quotes in
                completionHandler(.success(quotes))
            }) { error in
                completionHandler(.failure(NetworkError.userNotLoggedIn))
            }.disposed(by: disposeBag)
            return
        }
        
        let requestProperties = RequestProperties<UserSession>(baseUrl: configuration.baseApiUrl,
                                                               endPoint: .fetchUserQuotes(userSession.login),
                                                               method: .get,
                                                               headers: buildHeaders(),
                                                               parameters: nil)
        
        networkService.sendRequest(with: requestProperties) { [weak self] (result: Result<FavQuotesResponse, Error>) in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let favQuotesResponse):
                let quotes = favQuotesResponse.quotes
                completionHandler(.success(quotes))
                self.saveQuotesLocally(quotes)
                break
                
            case .failure(let error as NetworkError):
                switch error {
                case .userNotLoggedIn:
                    self.localStorageService.fetchQuotesIfAvailable().subscribe(onSuccess: { quotes in
                        completionHandler(.success(quotes))
                    }) { error in
                        completionHandler(.failure(NetworkError.userNotLoggedIn))
                    }.disposed(by: self.disposeBag)
                    break
                    
                default: completionHandler(.failure(error))
                }
                
            case .failure(let error): completionHandler(.failure(error))
            }
        }
    }
    
    private func saveQuotesLocally(_ quotes: [Quote]) {
        localStorageService.saveLocallyQuotes(quotes: quotes).subscribe(onCompleted: {
            print("New fav quotes are saved locally!")
        }) { error in
            print("Error when saving new fav quotes: \(error.localizedDescription)")
        }.disposed(by: self.disposeBag)
    }
    
    private func buildHeaders() -> HTTPHeaders {
        return [
            "Content-Type": "application/json",
            "Authorization": "Token token=\"\(configuration.apiKey)\""
        ]
    }
}
