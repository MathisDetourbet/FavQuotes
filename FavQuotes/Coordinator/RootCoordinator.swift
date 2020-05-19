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
    
    init() {
        let userFavQuotesViewController = UserFavQuotesViewController(routingDelegate: self)
        rootViewController = UINavigationController(rootViewController: userFavQuotesViewController)
    }
}

extension RootCoordinator: UserFavQuotesRouting {
    
    func showLogin() {
        
    }
}
