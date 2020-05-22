//
//  LocaleStorageService.swift
//  FavQuotes
//
//  Created by Mathis Detourbet on 22/5/20.
//  Copyright © 2020 Mathis Detourbet. All rights reserved.
//

import Foundation
import RxSwift

enum LocalStorageError: Error {
    case noDataForGivenKey, unarchiverError
}

final class LocalStorageService {
    
    private static let userFavQuotesUserDefaultsKey = "com.MathisDetourbet.FavQuotes.UserFavQuotes"
    
    private var userDefaults: UserDefaults {
        return UserDefaults.standard
    }
    
    func saveLocallyQuotes(quotes: [Quote]) -> Completable {
        Completable.create { [weak self] completable in
            do {
                let data = try NSKeyedArchiver.archivedData(withRootObject: quotes, requiringSecureCoding: false)
                self?.userDefaults.set(data, forKey: LocalStorageService.userFavQuotesUserDefaultsKey)
                self?.userDefaults.synchronize()
                completable(.completed)
                
            } catch {
                completable(.error(error))
                return Disposables.create {}
            }
            
            return Disposables.create {}
        }
    }
    
    func fetchQuotesIfAvailable() -> Single<[Quote]> {
        Single.create { [weak self] single in
            guard let data = self?.userDefaults.object(forKey: LocalStorageService.userFavQuotesUserDefaultsKey) as? Data else {
                single(.error(LocalStorageError.noDataForGivenKey))
                return Disposables.create {}
            }
            
            do {
                if let quotes = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [Quote] {
                    single(.success(quotes))
                    
                } else {
                    single(.error(LocalStorageError.unarchiverError))
                }
            } catch  {
                single(.error(error))
            }
            
            return Disposables.create {}
        }
    }
}
