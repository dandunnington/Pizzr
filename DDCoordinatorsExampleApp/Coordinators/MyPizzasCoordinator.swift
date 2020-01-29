//
//  MyPizzasCoordinator.swift
//  DDCoordinatorsExampleApp
//
//  Created by Dan Dunnington on 05/01/2020.
//  Copyright © 2020 Dan Dunnington. All rights reserved.
//

import Foundation
import DDCoordinators

class MyPizzasCoordinator: Coordinator<Bool> {
    
    // MARK: - Overrides
    override func makeStartStrategy() -> CoordinatorStartStrategy {
        .viewController(MyPizzasViewController(
            viewModel: myPizzasViewModel
        ))
    }
    
    // MARK: - Private Interface
    private lazy var myPizzasViewModel = MyPizzasViewModel(coordinator: self)
    
}

extension MyPizzasCoordinator: MyPizzaViewModelDelegate {
    func addTapped(_ viewModel: MyPizzasViewModel) {
        AddPizzaCoordinator(
            parent: self,
            presentingStrategy: .pushFromCoordinator(self),
            completed: myPizzasViewModel.addPizza(pizza:),
            cancelled: nil
        ).start(animated: true)
    }
}
