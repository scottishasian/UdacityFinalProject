//
//  SelectionViewController.swift
//  UdacityCocktailApp
//
//  Created by Kynan Song on 06/01/2019.
//  Copyright © 2019 Kynan Song. All rights reserved.
//

import UIKit
//import CoreData

class SelectionViewController: UIViewController {

    @IBOutlet weak var ingredientsButton: UIButton!
    @IBOutlet weak var ingredientsTableView: UITableView!
    
    var ingredientsList = ["Rum", "Tequila", "Whisky", "Vodka"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientsTableView.dataSource = self
        ingredientsTableView.isHidden = true

        // Do any additional setup after loading the view.
    }

    

    @IBAction func dropDownTapped(_ sender: Any) {
        let toggle = ingredientsTableView.isHidden
        animateDropDown(toggle: toggle)

    }
    
    func animateDropDown(toggle: Bool) {
        if toggle {
            UIView.animate(withDuration: 0.3) {
                self.ingredientsTableView.isHidden = false
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.ingredientsTableView.isHidden = true
            }
        }
    }
    

}


extension SelectionViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredientsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath)
        cell.textLabel?.text = ingredientsList[indexPath.row]
        //Will be populated via inserted data later.
        return cell
    }
    
    
    
}
