//
//  DataManager_SeedData.swift
//  UdacityCocktailApp
//
//  Created by Kynan Song on 09/01/2019.
//  Copyright © 2019 Kynan Song. All rights reserved.
//

import Foundation
import CoreData

extension DataManager {
    
    private func seedIngredients() {
        

        let baseIngredients = [
            (name: "Cointrieu", reference: 1),
            (name: "Vodka", reference: 2),
            (name: "Gin", reference: 3),
            (name: "Rum", reference: 4),
            (name: "Tequila", reference: 5),
            (name: "Whisky", reference: 6),
            (name: "Bourbon", reference: 7),
            (name: "Mescal", reference: 8),
            (name: "Campari", reference: 9),
            (name: "Vermouth", reference: 10),
            (name: "Lime", reference: 11),
            (name: "Lemon", reference: 12)
            
        ]
        
        for ingredient in baseIngredients {
            let ingredientsList = NSEntityDescription.insertNewObject(forEntityName: "Ingredients", into: context) as? Ingredients
            ingredientsList?.name = ingredient.name
            print(ingredientsList!)
        }
        
        do {
            try context.save()
        } catch _ {
            
        }
    }
    
    public func printIngredients() {
        let ingredientFetchRequest = NSFetchRequest<Ingredients>(entityName: "Ingredients")
        let primarySortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        
        ingredientFetchRequest.sortDescriptors = [primarySortDescriptor]
        
        let allIngredients = (try! context.fetch(ingredientFetchRequest as! NSFetchRequest<NSFetchRequestResult>)) as! [Ingredients]
        
        for ingredient in allIngredients {
            print("Ingredient Name: \(ingredient.name)", terminator: "")
        }
    }
    
}
