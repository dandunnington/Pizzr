//
//  AddPizzaCoordinator.swift
//  DDCoordinatorsExampleApp
//
//  Created by Dan Dunnington on 26/01/2020.
//  Copyright © 2020 Dan Dunnington. All rights reserved.
//

import Foundation
import DDCoordinators

class AddPizzaCoordinator: Coordinator<Pizza> {
    
    override func makeStartStrategy() -> CoordinatorStartStrategy {
        return .viewController(
            AddPizzaViewController(viewModel: AddPizzaViewModel(coordinator: self))
        )
    }
}

extension AddPizzaCoordinator: AddPizzaViewModelDelegate {
    func didCompleteWith(pizza: Pizza) {
        self.complete(data: pizza, animated: true)
    }
}
