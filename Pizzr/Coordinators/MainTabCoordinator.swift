//
//  MainTabCoordinator.swift
//  Pizzr
//
//  Created by Dan Dunnington on 23/02/2020.
//  Copyright © 2020 Dan Dunnington. All rights reserved.
//

import Foundation
import UIKit
import LittleJohn

class MainTabCoordinator: TabCoordinator {
    
    override func createChildren() -> [TabCoordinator.Tab] {
    
        let myPizzesCoordinator = MyPizzasCoordinator(presentingStrategy: .tab)
        let dessertsCoordinator = FavouriteDessertsCoordinator(presentingStrategy: .tab)
        
        return [
            Tab(coordinator: myPizzesCoordinator,
                tabBarItem: UITabBarItem(tabBarSystemItem: .favorites, tag: 0)),
            Tab(coordinator: dessertsCoordinator,
                tabBarItem: UITabBarItem(tabBarSystemItem: .favorites, tag: 1))
        ]
    }
    
}
