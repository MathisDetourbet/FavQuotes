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
    let isUserLogged: BehaviorSubject<Bool>
    
    private let dataAccessor: LoginDataAccess
    
    init(dataAccessor: LoginDataAccess) {
        self.dataAccessor = dataAccessor
        
        self.login = BehaviorSubject<String>(value: "")
        self.password = BehaviorSubject<String>(value: "")
        self.isUserLogged = BehaviorSubject<Bool>(value: false)
        
        self.isValid = Observable.combineLatest(login.asObservable(), password.asObservable()) { (login, password) in
            return (login.count > 0) && (password.count > 4)
        }
    }
    
    private func loginUser() {
        do {
            dataAccessor.fetchUserSession(login: try login.value(), password: try password.value()) { [weak self] error in
                if let error = error {
                    // Display error to the user in a AlertController 
                    print(error)
                } else {
                    // User is logged in
                    self?.isUserLogged.onNext(true)
                }
            }
        } catch {
            print(error)
        }
    }
    
    internal func userWantsToLogin() {
        loginUser()
    }
}
