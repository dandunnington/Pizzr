//
//  FavouriteDessertsCoordinator.swift
//  Pizzr
//
//  Created by Dan Dunnington on 23/02/2020.
//  Copyright © 2020 Dan Dunnington. All rights reserved.
//

import Foundation
import LittleJohn

class FavouriteDessertsCoordinator: ViewModelledViewControllerCoordinator<NoReturn, FavouriteDessertsViewModel> {
    
    override func makeRootViewController() -> UIViewControllerType {
        return FavouriteDessertsViewController(viewModel: .init())
    }
    
    
}
