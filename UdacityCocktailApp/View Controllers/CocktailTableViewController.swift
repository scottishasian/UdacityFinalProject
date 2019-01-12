//
//  CocktailTableViewController.swift
//  UdacityCocktailApp
//
//  Created by Kynan Song on 06/01/2019.
//  Copyright © 2019 Kynan Song. All rights reserved.
//

import UIKit
import CoreData

class CocktailTableViewController: UITableViewController {

    @IBOutlet var cocktailList: UITableView!
    
    var fetchResultController : NSFetchedResultsController<Cocktail>!
    
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
        
        //let fetchRequest = NSFetchRequest<Ingredients>(entityName: "Ingredients")
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


    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let arrayCount = fetchResultController.fetchedObjects
        return arrayCount!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cocktailCell", for: indexPath)
        let cocktail = fetchResultController.object(at: indexPath)
        cell.textLabel?.text = cocktail.name
        return cell
    }


}

extension CocktailTableViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        cocktailList.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        cocktailList.endUpdates()
    }
    
}
