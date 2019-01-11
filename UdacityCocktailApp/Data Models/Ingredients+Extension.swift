//
//  Ingredients+Extension.swift
//  UdacityCocktailApp
//
//  Created by Kynan Song on 06/01/2019.
//  Copyright © 2019 Kynan Song. All rights reserved.
//

import Foundation
import CoreData

extension Ingredients {
    
    static let name = "Ingredients"
    
    convenience init(name: String, reference: NSSet, context: NSManagedObjectContext) {
        if let savedEntity = NSEntityDescription.entity(forEntityName: Ingredients.name, in: context) {
            self.init(entity: savedEntity, insertInto: context)
            self.name = name
            self.reference = reference
        } else {
            fatalError("Entity name not found")
        }
    }
    
}
