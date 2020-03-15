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

final class AddPizzaCoordinator: ViewControllerCoordinator<Pizza>, NotificationEnabledCoordinator {
    
    private var pizza: Pizza?
    
    static var identifier: CoordinatorIdentifier {
        return CoordinatorIdentifier(name: "addPizza")
    }
    
    override func makeRootViewController() -> UIViewControllerType {
        AddPizzaViewController(viewModel: AddPizzaViewModel(coordinator: self, pizza: pizza))
    }
    
    deinit {
        print("Deinit on AddPizzaCoordinator")
    }
    
    convenience init(data: [String: Any], presentationStrategy presentingStrategy: CoordinatorPresentingStrategy) {
        self.init(presentingStrategy: presentingStrategy, completed: nil, cancelled: nil)
        guard data.count > 0 else { return }
        do {
            let dataObj = try JSONSerialization.data(withJSONObject: data)
            pizza = try JSONDecoder().decode(Pizza.self, from: dataObj)
        } catch {
            print(error)
        }
    }
    
    
}

extension AddPizzaCoordinator: AddPizzaViewModelDelegate {
    func didCompleteWith(pizza: Pizza) {
        self.complete(data: pizza, animated: true)
    }
}
