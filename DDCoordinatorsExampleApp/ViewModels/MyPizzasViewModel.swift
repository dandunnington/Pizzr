//
//  MyPizzasViewModel.swift
//  DDCoordinatorsExampleApp
//
//  Created by Dan Dunnington on 05/01/2020.
//  Copyright © 2020 Dan Dunnington. All rights reserved.
//

import Foundation
import DDCoordinators

class MyPizzasViewModel: BaseViewModel {
    
    internal var pizzas: [Pizza] = [] {
        didSet {
            updateUI?()
        }
    }
    
    internal var coordinator: MyPizzaViewModelDelegate
    
    // MARK: - Mutating Methods
    internal func addPizza(pizza: Pizza) {
        pizzas.append(pizza)
        updateUI?()
    }
    
    // MARK: - Table View Methods
    internal func cellForRowAt(index: Int) -> Cell {
        return Cell(model: pizzas[index])
    }
    
    internal var numberOfRows: Int {
        return pizzas.count
    }
    
    // MARK: - UI Actions
    internal func addTapped() {
        coordinator.addTapped(self)
    }
    
    // MARK: - UI Events
    internal var updateUI: (() -> Void)?
    
    // MARK: - Overrides
    override var navTitle: String? {
        return "My Pizzas"
    }
    
    // MARK: - Initialisers
    init(coordinator: MyPizzaViewModelDelegate) {
        self.coordinator = coordinator
        super.init()
    }
    
    // MARK: - Supporting Types
    internal struct Cell {
        
        private let model: Pizza
        
        var titleText: String {
            return model.name
        }
        
        var middleText: String {
            return "Cheese: \(model.cheese.displayName)"
        }
        
        var bottomText: String {
            return model.toppings.map { $0.displayName }.joined(separator: ",")
        }
        
        fileprivate init(model: Pizza) {
            self.model = model
        }
        
    }
}

protocol MyPizzaViewModelDelegate {
    func addTapped(_ viewModel: MyPizzasViewModel)
}
