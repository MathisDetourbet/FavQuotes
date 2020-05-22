//
//  UserFavQuotesViewModel.swift
//  FavQuotes
//
//  Created by Mathis Detourbet on 19/5/20.
//  Copyright © 2020 Mathis Detourbet. All rights reserved.
//

import Foundation
import RxSwift

final class FavQuotesViewModel: TableViewModel {
    internal var model: [QuoteViewModel]
    
    private let disposeBag = DisposeBag()
    
    private let dataAccess: FavQuotesDataAccess
    
    public var isUserLoggedObs: Observable<Bool> {
        return dataAccess.isLogged
    }
    
    private let needsReloadFavQuotesSubject = PublishSubject<Void>()
    var needsReloadFavQuotesObs: Observable<Void> {
        return needsReloadFavQuotesSubject.asObservable()
    }
    
    init(dataAccess: FavQuotesDataAccess) {
        self.dataAccess = dataAccess
        self.model = []
        
        isUserLoggedObs.startWith(false).distinctUntilChanged().subscribe(onNext: { [weak self] _ in
            self?.fetchUserFavQuotes()
        }).disposed(by: disposeBag)
    }
    
    private func fetchUserFavQuotes() {
        dataAccess.fetchUserFavQuotes { [weak self] (result: Result<[Quote], Error>) in
            switch result {
            case .success(let quotes):
                self?.model = quotes.map(QuoteViewModel.init)
                self?.needsReloadFavQuotesSubject.onNext(())
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
