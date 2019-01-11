//
//  SelectionViewController.swift
//  UdacityCocktailApp
//
//  Created by Kynan Song on 06/01/2019.
//  Copyright © 2019 Kynan Song. All rights reserved.
//

import UIKit
import CoreData

class SelectionViewController: UIViewController {

    @IBOutlet weak var ingredientsButton: UIButton!
    @IBOutlet weak var ingredientsTableView: UITableView!
    
    var fetchResultController : NSFetchedResultsController<Ingredients>!
    var ingredientsData = [Ingredients]()
    var ingredientsList = ["Rum", "Tequila", "Whisky", "Vodka"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientsTableView.dataSource = self
        ingredientsTableView.isHidden = true
        DataManager.sharedInstance().seedIngredients()
        // Do any additional setup after loading the view.
    }

    //https://stackoverflow.com/questions/27508771/core-data-many-to-many-relationship
    //https://stackoverflow.com/questions/24146524/setting-an-nsmanagedobject-relationship-in-swift/24146727#24146727
    //https://stackoverflow.com/questions/29028574/ios-swift-how-to-store-array-with-core-data
    

    @IBAction func dropDownTapped(_ sender: Any) {
        let toggle = ingredientsTableView.isHidden
        animateDropDown(toggle: toggle)
        //DataManager.sharedInstance().printIngredients()

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
    
    func fetchIngredientsList() {
        
        let fetchRequest = NSFetchRequest<Ingredients>(entityName: "Ingredients")
        let primarySortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [primarySortDescriptor]
        
        fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: DataManager.sharedInstance().context, sectionNameKeyPath: nil, cacheName: nil)
        fetchResultController.delegate = self as? NSFetchedResultsControllerDelegate
        
        var error: NSError?
        do {
            try self.fetchResultController.performFetch()
        } catch let fetchError as NSError {
            error = fetchError
        }
        
        if let error = error {
            print("\(error)")
        }
        
    }
    
}


extension SelectionViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //guard let ingredients = fetchResultController.fetchedObjects else {return 0}
        //return ingredients.count
        return ingredientsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath)
        //cell.textLabel?.text = ingredientsList[indexPath.row]
        let ingredients = fetchResultController.object(at: indexPath)
        cell.textLabel?.text = ingredients.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Did select \(ingredientsList[indexPath.row])")
    }
}


