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
    //var ingredientsData = [Ingredients]()
    var ingredientsList = ["Rum", "Tequila", "Whisky", "Vodka"]
    var ingredientReferenceToPass: NSSet = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientsTableView.dataSource = self
        ingredientsTableView.delegate = self
        ingredientsTableView.isHidden = true
        DataManager.sharedInstance().seedIngredients()
        fetchIngredientsList()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let indexPath = ingredientsTableView.indexPathForSelectedRow {
            ingredientsTableView.deselectRow(at: indexPath, animated: false)
            ingredientsTableView.reloadRows(at: [indexPath], with: .fade)
        }
    }

    //https://stackoverflow.com/questions/27508771/core-data-many-to-many-relationship
    //https://stackoverflow.com/questions/24146524/setting-an-nsmanagedobject-relationship-in-swift/24146727#24146727
    //https://stackoverflow.com/questions/29028574/ios-swift-how-to-store-array-with-core-data
    

    @IBAction func dropDownTapped(_ sender: Any) {
        let toggle = ingredientsTableView.isHidden
        animateDropDown(toggle: toggle)
        //DataManager.sharedInstance().printIngredients()
        ingredientsTableView.reloadData()

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
        
        //let fetchRequest = NSFetchRequest<Ingredients>(entityName: "Ingredients")
        let fetchRequest: NSFetchRequest<Ingredients> = Ingredients.fetchRequest()
        let primarySortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [primarySortDescriptor]
        
        fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: DataManager.sharedInstance().context, sectionNameKeyPath: nil, cacheName: "ingredients")
        fetchResultController.delegate = self
        
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
        let arrayCount = fetchResultController.fetchedObjects
        return arrayCount!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath)
        let ingredients = fetchResultController.object(at: indexPath)
        cell.textLabel?.text = ingredients.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = ingredientsTableView.cellForRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        let ingredient = fetchResultController.object(at: indexPath)
        ingredientReferenceToPass = ingredient.reference!
        print("tapped: \(ingredient.name)")
        performSegue(withIdentifier: "cocktailListSegue", sender: cell)
    }
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if(segue.identifier == "cocktailListSegue") {
                let viewController = segue.destination as! CocktailTableViewController
                viewController.ingredientsReference = ingredientReferenceToPass
            }
        }
}


