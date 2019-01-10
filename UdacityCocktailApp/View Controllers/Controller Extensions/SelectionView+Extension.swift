//
//  SelectionView+Extension.swift
//  UdacityCocktailApp
//
//  Created by Kynan Song on 10/01/2019.
//  Copyright © 2019 Kynan Song. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension SelectionViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        ingredientsTableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        ingredientsTableView.endUpdates()
        
        performUIUpdatesOnMain {
            var hasIngredients = false
            
            if let ingredients = self.fetchResultController.fetchedObjects {
                hasIngredients = ingredients.count > 0
            }
            
            self.ingredientsTableView.isHidden = !hasIngredients
        }
    }
    
}
