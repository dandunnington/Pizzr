//
//  Pizza.swift
//  Pizzr
//
//  Created by Dan Dunnington on 05/01/2020.
//  Copyright © 2020 Dan Dunnington. All rights reserved.
//

import Foundation

struct Pizza: Decodable {
    var name: String
    var toppings: [PizzaTopping]
    var cheese: Cheese
}

enum PizzaTopping: String, Decodable, CaseIterable {
    
    case pepperoni
    case peppers
    case onions
    case prawns
    
    var displayName: String {
        return self.rawValue.capitalized
    }
}

enum Cheese: String, Decodable, CaseIterable {
    
    case cheddar
    case mozzarella
    case stilton
    
    var displayName: String {
        return self.rawValue.capitalized
    }
}
