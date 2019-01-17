//
//  AddCocktailViewController.swift
//  UdacityCocktailApp
//
//  Created by Kynan Song on 06/01/2019.
//  Copyright © 2019 Kynan Song. All rights reserved.
//

import UIKit
import CoreData

class AddCocktailViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var cocktailName: UITextField!
    @IBOutlet weak var ingredient1: UITextField!
    @IBOutlet weak var ingredient2: UITextField!
    @IBOutlet weak var ingredient3: UITextField!
    
    @IBOutlet weak var measurementsTextField: UITextView!
    @IBOutlet weak var cocktailInformationTextField: UITextView!
    

    //https://cocoacasts.com/implement-the-nsfetchedresultscontrollerdelegate-protocol-with-swift-3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cocktailName.delegate = self
        self.ingredient1.delegate = self
        self.ingredient2.delegate = self
        self.ingredient3.delegate = self
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func saveCocktail(_ sender: Any) {
        let newCocktailName = cocktailName.text
        let firstIngredient = ingredient1.text
        let secondIngredient = ingredient2.text
        let thirdIngredient = ingredient3.text
        let measurements = measurementsTextField.text
        let information = cocktailInformationTextField.text
        
        if (newCocktailName?.isEmpty)! || (firstIngredient?.isEmpty)! || (secondIngredient?.isEmpty)! {
            showInfo(withMessage: "A cocktail needs a name and at least two ingredients")
            return
        }
        print("Saving cocktail")
        
        let newCocktail = Cocktail(context: DataManager.sharedInstance().context)
        newCocktail.name = newCocktailName
        newCocktail.measurments = measurements
        newCocktail.information = information
        
        saveData() 
        // TODO: Check if cocktail name is already in database.
        
    }
    

}
