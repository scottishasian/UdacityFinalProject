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
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
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
