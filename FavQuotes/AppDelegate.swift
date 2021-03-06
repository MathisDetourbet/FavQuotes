//
//  AppDelegate.swift
//  FavQuotes
//
//  Created by Mathis Detourbet on 18/5/20.
//  Copyright © 2020 Mathis Detourbet. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var rootCoordinator: RootCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        rootCoordinator = RootCoordinator()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootCoordinator?.rootViewController
        window?.makeKeyAndVisible()
        
        return true
    }
}

