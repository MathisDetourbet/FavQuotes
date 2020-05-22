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
    
    let loginSubject: BehaviorSubject<String>
    let passwordSubject: BehaviorSubject<String>
    let isUserLoggedSubject: BehaviorSubject<Bool>
    let isValidObs: Observable<Bool>
    
    private let dataAccessor: LoginDataAccess
    
    init(dataAccessor: LoginDataAccess) {
        self.dataAccessor = dataAccessor
        
        self.loginSubject = BehaviorSubject<String>(value: "")
        self.passwordSubject = BehaviorSubject<String>(value: "")
        self.isUserLoggedSubject = BehaviorSubject<Bool>(value: false)
        
        self.isValidObs = Observable.combineLatest(loginSubject.asObservable(), passwordSubject.asObservable()) { (login, password) in
            return (login.count > 0) && (password.count > 4)
        }
    }
    
    private func loginUser() {
        do {
            dataAccessor.fetchUserSession(login: try loginSubject.value(), password: try passwordSubject.value()) { [weak self] error in
                if let error = error {
                    // Display error to the user in a AlertController 
                    print(error.localizedDescription)
                } else {
                    // User is logged in
                    self?.isUserLoggedSubject.onNext(true)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    internal func userWantsToLogin() {
        loginUser()
    }
}
