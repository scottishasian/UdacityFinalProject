//
//  CocktailTableViewController.swift
//  UdacityCocktailApp
//
//  Created by Kynan Song on 06/01/2019.
//  Copyright © 2019 Kynan Song. All rights reserved.
//

import UIKit
import CoreData

class CocktailTableViewController: UIViewController {

    @IBOutlet var cocktailList: UITableView!
    
    var fetchResultController : NSFetchedResultsController<Cocktail>!
    var cocktailNameToPass:String!
    var cocktailInformationToPass:String!
    var cocktailMeasurementsToPass:String!
    var ingredientsReference: NSSet?
    
    var selectedIndexes = [IndexPath]()
    var insertedIndexPaths: [IndexPath]!
    var deletedIndexPaths: [IndexPath]!
    var updatedIndexPaths: [IndexPath]!
    var arrayCount:[Cocktail]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cocktailList.dataSource = self
        cocktailList.delegate = self
        fetchCocktailsList()
        arrayCount = fetchResultController.fetchedObjects
//        if arrayCount.count == 0 {
//            //Doesn't load data on intial view.
//            DataManager.sharedInstance().seedCocktails()
//            fetchCocktailsList()
//            arrayCount = fetchResultController.fetchedObjects
//            cocktailList.reloadData()
//            print(arrayCount.count)
//        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let indexPath = cocktailList.indexPathForSelectedRow {
            cocktailList.deselectRow(at: indexPath, animated: false)
            cocktailList.reloadRows(at: [indexPath], with: .fade)
        }
    }
    
    func fetchCocktailsList() {
        
        //Needs to change to draw from joining table.
        //https://stackoverflow.com/questions/15062860/fetching-data-using-join-table-in-coredata
        
        let fetchRequest: NSFetchRequest<Cocktail> = Cocktail.fetchRequest()
        let primarySortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [primarySortDescriptor]
        
        //let referencePredicate = NSPredicate(format: "ingredientReference == %@", ingredientsReference!)
        //let allCocktails = (try! DataManager.sharedInstance().context.fetch(fetchRequest as! NSFetchRequest<NSFetchRequestResult>)) as! [Cocktail]
    
//        for cocktail in allCocktails {
//            let filteredCocktails = cocktail.ingredientReference?.filtered(using: referencePredicate)
//            if (filteredCocktails?.count)! > 0 {
//                let listObject = filteredCocktails
//                print("Ingredient Name: \(cocktail.name)", terminator: "")
//            }
//        }
        
        fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: DataManager.sharedInstance().context, sectionNameKeyPath: nil, cacheName: "cocktails")
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
    // MARK: - Table view data source
extension CocktailTableViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //let arrayCount = fetchResultController.fetchedObjects
        return arrayCount!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cocktailCell", for: indexPath)
        let cocktail = arrayCount![indexPath.row]
        cell.textLabel?.text = cocktail.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = cocktailList.cellForRow(at: indexPath)
        let cocktail = fetchResultController.object(at: indexPath)
        cocktailNameToPass = cocktail.name
        cocktailMeasurementsToPass = cocktail.measurments
        cocktailInformationToPass = cocktail.information
        print("tapped: \(cocktail.name)")
        performSegue(withIdentifier: "cocktailInformationSegue", sender: cell)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "cocktailInformationSegue") {
            let viewController = segue.destination as! CocktailInformationViewController
            viewController.sentName = cocktailNameToPass
            viewController.sentInformation = cocktailInformationToPass
            viewController.sentMeasurements = cocktailMeasurementsToPass
        }
    }


}

