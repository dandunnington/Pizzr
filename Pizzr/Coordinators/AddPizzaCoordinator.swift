//
//  AddPizzaCoordinator.swift
//  Pizzr
//
//  Created by Dan Dunnington on 26/01/2020.
//  Copyright © 2020 Dan Dunnington. All rights reserved.
//

import Foundation
import LittleJohn
import UIKit

class AddPizzaCoordinator: ViewControllerCoordinator<Pizza> {
    
    override func makeRootViewController() -> UIViewControllerType {
        AddPizzaViewController(viewModel: AddPizzaViewModel(coordinator: self))
    }
    
    deinit {
        print("Deinit on AddPizzaCoordinator")
    }
}

extension AddPizzaCoordinator: AddPizzaViewModelDelegate {
    func didCompleteWith(pizza: Pizza) {
        self.complete(data: pizza, animated: true)
    }
}
