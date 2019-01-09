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
            ("Cointrieu"),
            ("Vodka"),
            ("Gin"),
            ("Rum"),
            ("Tequila"),
            ("Whisky"),
            ("Bourbon"),
            ("Mescal"),
            ("Campari"),
            ("Vermouth"),
            ("Lime"),
            ("Lemon")
            ]
        
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
        //not working currently
        let ingredientFetchRequest = NSFetchRequest<Ingredients>(entityName: "Ingredients")
        let primarySortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        
        ingredientFetchRequest.sortDescriptors = [primarySortDescriptor]
        
        let ingredientsList = (try! context.fetch(ingredientFetchRequest as! NSFetchRequest<NSFetchRequestResult>)) as! [Ingredients]
        
        for ingredient in ingredientsList {
            print("Ingredient name: \(String(describing: ingredient.name))")
        }
    }
    
}
