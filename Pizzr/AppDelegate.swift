//
//  AppDelegate.swift
//  Pizzr
//
//  Created by Dan Dunnington on 05/01/2020.
//  Copyright © 2020 Dan Dunnington. All rights reserved.
//

import UIKit
import LittleJohn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let rootNavigationController = UINavigationController()
    
    var appCoordinator: AppCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = rootNavigationController
        window.makeKeyAndVisible()
        self.window = window
        
        NotificationCenter.default.addObserver(self, selector: #selector(testRouter), name: .simulateNotification, object: nil)
        
        appCoordinator = AppCoordinator(presentingStrategy: .pushNavigationController(rootNavigationController))
        appCoordinator?.start(animated: false)
        
        return true
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {

        appCoordinator?.performNotificationRoute(userInfo: userInfo)
        
    }
    
    /// Test function to enable the user of the app to simulate a notification. This would not normally be in here
    @objc private func testRouter() {
        let file = Bundle.main.url(forResource: "notification", withExtension: "json")!
        
        do {
            let data = try JSONSerialization.jsonObject(with: try Data(contentsOf: file), options: .mutableContainers)
            
            appCoordinator?.performNotificationRoute(userInfo: data as! [String: Any])
        } catch {
            appCoordinator?.displayAlert(title: "Issue loading JSON", body: "There was an issue loading the JSON file for the sample notification")
        }
    }
}

extension Notification.Name {
    static let simulateNotification = Notification.Name("simulateNotification")
}
