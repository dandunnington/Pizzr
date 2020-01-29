//
//  AppCoordinator.swift
//  DDCoordinatorsExampleApp
//
//  Created by Dan Dunnington on 12/01/2020.
//  Copyright © 2020 Dan Dunnington. All rights reserved.
//

import Foundation
import DDCoordinators
import UIKit

class AppCoordinator: Coordinator<Bool> {
    
    var window: UIWindow?
    
    override func makeStartStrategy() -> CoordinatorStartStrategy {
        .childCoordinator(MyPizzasCoordinator(
            parent: self,
            presentingStrategy: .pushFromCoordinator(self)
        ))
    }
    
}
