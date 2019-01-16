//
//  Cocktails+Extension.swift
//  UdacityCocktailApp
//
//  Created by Kynan Song on 06/01/2019.
//  Copyright © 2019 Kynan Song. All rights reserved.
//

import Foundation
import CoreData

extension Cocktail {
    
    static let name = "Cocktails"
    
    convenience init(name: String, measurements: String, information: String, ingredientReference: NSSet, context: NSManagedObjectContext) {
        if let savedEntity = NSEntityDescription.entity(forEntityName: Ingredients.name, in: context) {
            self.init(entity: savedEntity, insertInto: context)
            self.name = name
            self.measurments = measurements
            self.information = information
            self.ingredientReference = ingredientReference
        } else {
            fatalError("Entity name not found")
        }
    }
    
}
