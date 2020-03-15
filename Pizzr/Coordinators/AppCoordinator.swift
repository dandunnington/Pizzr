//
//  AppCoordinator.swift
//  Pizzr
//
//  Created by Dan Dunnington on 12/01/2020.
//  Copyright © 2020 Dan Dunnington. All rights reserved.
//

import Foundation
import LittleJohn
import UIKit

class AppCoordinator: DelegatingCoordinator<Bool>, AppCoordinatorType {
    
    var window: UIWindow?
    
    internal func displayAlert(title: String, body: String) {
        let alert = UIAlertController(title: title, message: body, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            alert.dismiss(animated: true, completion: nil)
        })
        self.navigationController?.present(alert, animated: true, completion: nil)
    }
    
    override func makeDelegatingCoordinator() -> CoordinatorType {
        MainTabCoordinator(presentingStrategy: .pushFromCoordinator(self))
    }
    
    override func didStart(animated: Bool) {
        super.didStart(animated: animated)
        registerNotificationEnabledCoordinators(container: NotficationCoordinatorRegister.shared)
    }
    
    internal func registerNotificationEnabledCoordinators(container: NotficationCoordinatorRegister) {
        container.register(AddPizzaCoordinator.self)
    }
}
