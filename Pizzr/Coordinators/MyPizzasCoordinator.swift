//
//  MyPizzasCoordinator.swift
//  Pizzr
//
//  Created by Dan Dunnington on 05/01/2020.
//  Copyright © 2020 Dan Dunnington. All rights reserved.
//

import Foundation
import UIKit
import DDCoordinators

class MyPizzasCoordinator: ViewModelledViewControllerCoordinator<Bool, MyPizzasViewModel> {
    
    // MARK: - Overrides
    override func makeViewModelledViewController() -> ViewModelledViewController<MyPizzasViewModel> {
        return MyPizzasViewController(viewModel: MyPizzasViewModel(coordinator: self))
    }
    
}

extension MyPizzasCoordinator: MyPizzaViewModelDelegate {
    func addTapped(_ viewModel: MyPizzasViewModel) {
        
        startChild(animated: true, AddPizzaCoordinator(
            presentingStrategy: .pushFromCoordinator(self),
            completed: viewModel.addPizza(pizza:),
            cancelled: nil
        ))
    }
}
