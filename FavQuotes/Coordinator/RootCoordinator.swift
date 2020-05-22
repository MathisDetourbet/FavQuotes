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
    private let networkService: NetworkLayer = NetworkService()
    
    init() {
        let favQuotesDataAccess: FavQuotesDataAccess = FavQuotesApiDataAccessor(configuration: configuration, networkService: networkService)
        let favQuotesViewModel = FavQuotesViewModel(dataAccess: favQuotesDataAccess)
        let favQuotesViewController = FavQuotesViewController(viewModel: favQuotesViewModel, routingDelegate: self)
        rootViewController = UINavigationController(rootViewController: favQuotesViewController)
    }
}

extension RootCoordinator: FavQuotesRouting {
    
    func showLogin() {
        let loginDataAccessor: LoginDataAccess = LoginDataAccessor(configuration: self.configuration, networkService: networkService)
        let loginViewModel = LoginViewModel(dataAccessor: loginDataAccessor)
        let loginViewController = LoginViewController(viewModel: loginViewModel, routingDelegate: self)
        rootViewController.viewControllers.last?.present(loginViewController, animated: true, completion: nil)
    }
    
    func showFavQuoteDetails(quoteDetailsViewModel: QuoteDetailsViewModel) {
        let quoteDetailsViewController = FavQuoteDetailsViewController(viewModel: quoteDetailsViewModel)
        rootViewController.pushViewController(quoteDetailsViewController, animated: true)
    }
}

extension RootCoordinator: LoginRouting {
    
    func dismiss() {
        rootViewController.dismiss(animated: true, completion: nil)
    }
    
    func loginSuccess() {
        rootViewController.dismiss(animated: true, completion: nil)
    }
}
