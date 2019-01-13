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
    
    var selectedIndexes = [IndexPath]()
    var insertedIndexPaths: [IndexPath]!
    var deletedIndexPaths: [IndexPath]!
    var updatedIndexPaths: [IndexPath]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cocktailList.dataSource = self
        cocktailList.delegate = self
        DataManager.sharedInstance().seedCocktails()
        fetchCocktailsList()
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
        let fetchRequest: NSFetchRequest<Cocktail> = Cocktail.fetchRequest()
        let primarySortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [primarySortDescriptor]
        
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
        let arrayCount = fetchResultController.fetchedObjects
        return arrayCount!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cocktailCell", for: indexPath)
        let cocktail = fetchResultController.object(at: indexPath)
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

