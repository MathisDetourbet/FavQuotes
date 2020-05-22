//
//  UserAuthenticationService.swift
//  FavQuotes
//
//  Created by Mathis Detourbet on 20/5/20.
//  Copyright © 2020 Mathis Detourbet. All rights reserved.
//

import Foundation
import RxSwift

final class UserAuthenticationService {
    var user: User? {
        didSet { updateUserState() }
    }
    
    var userSession: UserSession? {
        didSet { updateUserState() }
    }
    
    private let isLoggedSubject = BehaviorSubject<Bool>(value: false)
    public var isLoggedObs: Observable<Bool> {
        return isLoggedSubject.asObservable()
    }
    
    private func updateUserState() {
        isLoggedSubject.onNext(userSession != nil && user != nil)
    }
}
