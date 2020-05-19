//
//  RootCoordinator.swift
//  FavQuotes
//
//  Created by Mathis Detourbet on 19/5/20.
//  Copyright © 2020 Mathis Detourbet. All rights reserved.
//

import UIKit

final class RootCoordinator {
    
    var rootViewController: UINavigationController!
    
    private let configuration = Configuration()
    private let networkService: NetworkLayer
    
    init() {
        self.networkService = NetworkService()
        let userFavQuotesViewController = UserFavQuotesViewController(routingDelegate: self)
        rootViewController = UINavigationController(rootViewController: userFavQuotesViewController)
    }
}

extension RootCoordinator: UserFavQuotesRouting {
    
    func showLogin() {
        let loginDataAccessor: LoginDataAccess = LoginDataAccessor(configuration: self.configuration, networkService: networkService)
        let loginViewModel = LoginViewModel(dataAccessor: loginDataAccessor)
        let loginViewController = LoginViewController(viewModel: loginViewModel, routingDelegate: self)
        rootViewController.viewControllers.first?.present(loginViewController, animated: true, completion: nil)
    }
}

extension RootCoordinator: LoginRouting {
    
    func dismiss() {
        rootViewController.dismiss(animated: true, completion: nil)
    }
    
    func userIsLogged() {
        rootViewController.dismiss(animated: true, completion: nil)
    }
}
