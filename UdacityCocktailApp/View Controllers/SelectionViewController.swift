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
        DataManager.sharedInstance().printIngredients()
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // If this is a NotesListViewController, we'll configure its `Notebook`
        if let vc = segue.destination as? CocktailTableViewController {
//            if let indexPath = tableView.indexPathForSelectedRow {
//                //vc.notebook = notebook(at: indexPath)
//                vc.notebook = fetchedResultController.object(at: indexPath)
//                //Passing core data stack to Notes.
//                vc.dataController = dataController
            }
        print("Ingredient tapped")
        }
    
}

extension SelectionViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let arrayCount = fetchResultController.fetchedObjects
        //print("There are: \(arrayCount?.count)")
        return arrayCount!.count
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
        let cell = ingredientsTableView.cellForRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "cocktailListSegue", sender: cell)
    }
}


