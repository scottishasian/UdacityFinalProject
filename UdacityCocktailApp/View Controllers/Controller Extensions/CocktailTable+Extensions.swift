//
//  CocktailTable+Extensions.swift
//  UdacityCocktailApp
//
//  Created by Kynan Song on 13/01/2019.
//  Copyright © 2019 Kynan Song. All rights reserved.
//

import Foundation
import CoreData

extension CocktailTableViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        cocktailList.beginUpdates()
        insertedIndexPaths = [IndexPath]()
        deletedIndexPaths = [IndexPath]()
        updatedIndexPaths = [IndexPath]()
    }
    
    //Called when the fetchedResultContoller has been notified there are changes. Should updated affected rows.
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert: insertedIndexPaths.append(newIndexPath!)
            break
        case .delete: deletedIndexPaths.append(indexPath!)
            break
        case .update: updatedIndexPaths.append(indexPath!)
            break
        case .move:
            fatalError("Invalid change type in controller(_:didChange:atSectionIndex:for:). .move not possible")
            break
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        cocktailList.performBatchUpdates({() -> Void in
            
            for indexPath in self.insertedIndexPaths {
                self.cocktailList.insertRows(at: [indexPath], with: .left)
            }
            
            for indexPath in self.deletedIndexPaths {
                self.cocktailList.deleteRows(at: [indexPath], with: .left)
            }
            
            for indexPath in self.updatedIndexPaths {
                self.cocktailList.reloadRows(at: [indexPath], with: .left)
            }
            
        }, completion: nil)
    }
    
}
