//
//  AppDelegate.swift
//  Pizzr
//
//  Created by Dan Dunnington on 05/01/2020.
//  Copyright © 2020 Dan Dunnington. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let rootNavigationController = UINavigationController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = rootNavigationController
        window.makeKeyAndVisible()
        self.window = window
        
        AppCoordinator(presentingStrategy: .pushNavigationController(rootNavigationController)).start(animated: false)
        
        return true
    }

}

