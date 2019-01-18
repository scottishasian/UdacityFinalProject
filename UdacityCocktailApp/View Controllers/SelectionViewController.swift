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
    var ingredientReferenceToPass: NSSet = []
    var ingredientsArray : [Ingredients]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientsTableView.dataSource = self
        ingredientsTableView.delegate = self
        ingredientsTableView.isHidden = true
        checkIfFirstLaunch()
        fetchIngredientsList()
        ingredientsArray = fetchResultController.fetchedObjects
        UserDefaults.standard.set(true, forKey: "hasDataInTableIngredients")
        UserDefaults.standard.set(true, forKey: "hasDataInTableCocktails")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ingredientsTableView.reloadData()
        if let indexPath = ingredientsTableView.indexPathForSelectedRow {
            ingredientsTableView.deselectRow(at: indexPath, animated: false)
            ingredientsTableView.reloadRows(at: [indexPath], with: .fade)
        }
    }

    //https://stackoverflow.com/questions/27508771/core-data-many-to-many-relationship
    //https://stackoverflow.com/questions/24146524/setting-an-nsmanagedobject-relationship-in-swift/24146727#24146727
    //https://stackoverflow.com/questions/29028574/ios-swift-how-to-store-array-with-core-data
    
    func checkIfFirstLaunch() {
        if UserDefaults.standard.bool(forKey: "hasLaunchedBefore") {
            print("App has launched before")
        } else {
            print("This is the first launch ever!")
            UserDefaults.standard.set(true, forKey: "hasLaunchedBefore")
            UserDefaults.standard.set(true, forKey: "hasDataInTableIngredients")
            UserDefaults.standard.set(true, forKey: "hasDataInTableCocktails")
            DataManager.sharedInstance().seedIngredients()
            DataManager.sharedInstance().seedCocktails()
            saveData()
            UserDefaults.standard.synchronize()
        }
    }

    @IBAction func dropDownTapped(_ sender: Any) {
        let toggle = ingredientsTableView.isHidden
        animateDropDown(toggle: toggle)
        ingredientsTableView.reloadData()

    }

    @IBAction func logOut(_ sender: Any) {
        DataClient.sharedInstance().logoutUser { (success, error) in
            if success {
                self.dismiss(animated: true, completion: nil)
            } else {
                self.showInfo(withTitle: "Log Out Error", withMessage: (error?.localizedDescription)!)
            }
        }
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
        return ingredientsArray!.count
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


