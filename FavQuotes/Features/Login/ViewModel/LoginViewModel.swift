//
//  LoginViewModel.swift
//  FavQuotes
//
//  Created by Mathis Detourbet on 19/5/20.
//  Copyright © 2020 Mathis Detourbet. All rights reserved.
//

import Foundation
import RxSwift

protocol LoginDelegate: class {
    func userWantsToLogin()
}

final class LoginViewModel: LoginDelegate {
    
    let login: BehaviorSubject<String>
    let password: BehaviorSubject<String>
    let isValid: Observable<Bool>
    
    init() {
        login = BehaviorSubject<String>(value: "")
        password = BehaviorSubject<String>(value: "")
        
        isValid = Observable.combineLatest(login.asObservable(), password.asObservable()) { (login, password) in
            return (login.count > 0) && (password.count > 0)
        }
    }
    
    private func loginUser() {
        
    }
    
    internal func userWantsToLogin() {
        loginUser()
    }
}
