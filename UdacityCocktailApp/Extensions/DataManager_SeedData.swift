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
            (name: "Cointrieu"),
            (name: "Vodka"),
            (name: "Gin"),
            (name: "Rum"),
            (name: "Tequila"),
            (name: "Whisky"),
            (name: "Bourbon"),
            (name: "Mescal"),
            (name: "Campari"),
            (name: "Vermouth"),
            (name: "Lime"),
            (name: "Lemon")
            ] as [Any]
        
        for ingredient in baseIngredients {
            let ingredientsList = NSEntityDescription.insertNewObject(forEntityName: "Ingredients", into: context) as? Ingredients
            ingredientsList?.name = (ingredient as AnyObject).name
        }
        
        do {
            try context.save()
        } catch _ {
            
        }
    }
    
    public func printIngredients() {
        let ingredientFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Ingredients")
        let primarySortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        
        ingredientFetchRequest.sortDescriptors = [primarySortDescriptor]
        
        let ingredientsList = (try! context.execute(ingredientFetchRequest)) as! [Ingredients]
        
        for ingredient in ingredientsList {
            print("Ingredient name: \(ingredient.name)")
        }
    }
    
}
