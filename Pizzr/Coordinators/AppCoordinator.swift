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

class AppCoordinator: DelegatingCoordinator<Bool> {
    
    var window: UIWindow?
    
    override func makeDelegatingCoordinator() -> CoordinatorType {
        MainTabCoordinator(presentingStrategy: .pushFromCoordinator(self))
    }
    
}
