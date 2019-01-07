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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.cocktailName.delegate = self
        self.ingredient1.delegate = self
        self.ingredient2.delegate = self
        self.ingredient3.delegate = self
        // Do any additional setup after loading the view.
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func saveCocktail(_ sender: Any) {
        let cocktail = cocktailName.text
        let firstIngredient = ingredient1.text
        let secondIngredient = ingredient2.text
        let thirdIngredient = ingredient3.text
        let measurements = measurementsTextField.text
        let information = cocktailInformationTextField.text
        
        if (cocktail?.isEmpty)! || (firstIngredient?.isEmpty)! || (secondIngredient?.isEmpty)! {
            showInfo(withMessage: "A cocktail needs a name and at least two ingredients")
            return
        }
        print("Saving cocktail")
        //Check if cocktail name is already in database.
        
    }
    

}