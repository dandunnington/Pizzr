//
//  AddPizzaViewModel.swift
//  Pizzr
//
//  Created by Dan Dunnington on 26/01/2020.
//  Copyright © 2020 Dan Dunnington. All rights reserved.
//

import Foundation
import LittleJohn

class AddPizzaViewModel: BaseViewModel {

    private var name: String?
    
    private let cheeseOptions: [Cheese] = Cheese.allCases
    
    private let toppingsOptions: [PizzaTopping] = PizzaTopping.allCases
    
    private var selectedCheeseIndex: Int = 0
    
    private var selectedToppingIndexes: [Int] = []
    
    // MARK: - Overrides
    override var navTitle: String? {
        return "New Pizza"
    }
    
    // MARK: - Computed Properties
    private var selectedCheese: Cheese {
        return cheeseOptions[selectedCheeseIndex]
    }
    
    private var selectedToppings: [PizzaTopping] {
        return selectedToppingIndexes.map { toppingsOptions[$0] }
    }
    
    // MARK: - Public Interface
    internal var coordinator: AddPizzaViewModelDelegate
    
    // MARK: - UI Events
    internal var didOutputInvalidSave: ((InvalidState) -> Void)?
    
    // MARK: - UI Actions
    internal func textChangedOnNameField(to string: String?) {
        name = string
    }
    
    internal func saveTapped() {
        
        // validate
        guard let name = self.name, name.count > 0 else {
            didOutputInvalidSave?(.noName)
            return
        }
        guard selectedToppingIndexes.count > 0 else {
            didOutputInvalidSave?(.noToppings)
            return
        }
        coordinator.didCompleteWith(pizza: Pizza(
            name: name,
            toppings: selectedToppings,
            cheese: selectedCheese
        ))
    }
    
    // MARK: - Cheese Picker Values
    internal var numberOfPickerItems: Int {
        return cheeseOptions.count
    }
    
    internal func titleForCheesePicker(index: Int) -> String {
        return cheeseOptions[index].displayName
    }
    
    internal func cheesePickerSelected(index: Int) {
        self.selectedCheeseIndex = index
    }
    
    // MARK: - Toppings Table View
    internal var numberOfItemsInTopping: Int {
        return toppingsOptions.count
    }
    
    internal func cellForToppingItem(at index: Int) -> ToppingCell {
        return ToppingCell(
            title: toppingsOptions[index].displayName
        )
        
    }
    
    internal func selectedToppingCell(at tableIndex: Int) {
        if let arrIndex = selectedToppingIndexes.firstIndex(of: tableIndex) {
            selectedToppingIndexes.remove(at: arrIndex)
        } else {
            selectedToppingIndexes.append(tableIndex)
        }
    }
    
    internal func deselectedToppingCell(at tableIndex: Int) {
        selectedToppingIndexes.removeAll { $0 == tableIndex }
    }
    
    // MARK: - Initialisers
    init(coordinator: AddPizzaViewModelDelegate) {
        self.coordinator = coordinator
    }
    
    // MARK: - Supporting Structures
    enum InvalidState: Error {
        case noName
        case noToppings
    }
    
    struct ToppingCell {
        let title: String
    }
}

protocol AddPizzaViewModelDelegate {
    func didCompleteWith(pizza: Pizza)
}
