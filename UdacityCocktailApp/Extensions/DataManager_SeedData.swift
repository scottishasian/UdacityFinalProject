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
    
    //Ingredient seed data

    public func seedIngredients() {
        
        let baseIngredients = [
            (name: "Bourbon", reference: 1),
            (name: "Campari", reference: 2),
            (name: "Cointrieu", reference: 3),
            (name: "Gin", reference: 4),
            (name: "Lemon", reference: 5),
            (name: "Lime", reference: 6),
            (name: "Mescal", reference: 7),
            (name: "Rum", reference: 8),
            (name: "Tequila", reference: 9),
            (name: "Vermouth", reference: 10),
            (name: "Vodka", reference: 11),
            (name: "Whisky", reference: 12)

        ]
        
        for ingredient in baseIngredients {
            let ingredientsList = NSEntityDescription.insertNewObject(forEntityName: "Ingredients", into: persistedCOntext) as? Ingredients
            ingredientsList?.name = ingredient.name
            //print(ingredientsList!)
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

extension DataManager {
    
    //Cocktails seed data
    //Refactor this method so it can be re-used.
    public func seedCocktails() {
        
        let cocktailList = [
            (name: "Mojito", measurements: "50ml Rum, 8 Mint leaves, 15ml Gomme, 25ml Lime", information: "Muddle the lime, sugar and mint, then stir in the rum over crushed ice. Finish with Soda",  ingredientReference: 8),
            (name: "Old Fashioned", measurements: "50ml Bourbon or Rum, 1 sugar cube, 3 dashes Orange bitters, 3 dashes Angostura bitters", information: "Muddle the sugar and bitters into a treacle, then stir in the bourbon/rum over ice.",  ingredientReference: 1),
            (name: "Paloma", measurements: "50ml Tequila, 12.5ml Lime Juice, 75ml Grapefruit Juice/Soda, 12.5ml Agave, salt rim", information: "Build and stir in glass over ice.",  ingredientReference: 9),
            (name: "Whisky Mac", measurements: "50ml Whisky, 25ml Ginger Wine", information: "Build and stir in glass over ice.",  ingredientReference: 12),
            (name: "Daiquiri", measurements: "50ml Rum, 12.5ml Cointreau, 12.5ml Lime", information: "Add to shaker then double strain into glass.",  ingredientReference: 8),
        ]
        
        for cocktail in cocktailList {
            let cocktailList = NSEntityDescription.insertNewObject(forEntityName: "Cocktail", into: context) as? Cocktail
            cocktailList?.name = cocktail.name
            cocktailList?.measurments = cocktail.measurements
            //cocktailList?.ingredientReference = cocktail.ingredientReference
            cocktailList?.information = cocktail.information
            //print(cocktailList!)
        }
        
        do {
            try context.save()
        } catch _ {
            
        }
    }
    
}
