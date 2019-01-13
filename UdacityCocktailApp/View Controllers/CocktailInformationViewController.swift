//
//  CocktailInformationViewController.swift
//  UdacityCocktailApp
//
//  Created by Kynan Song on 06/01/2019.
//  Copyright © 2019 Kynan Song. All rights reserved.
//

import UIKit
import CoreData

class CocktailInformationViewController: UIViewController {

    @IBOutlet weak var cocktailName: UILabel?
    @IBOutlet weak var cocktailInformation: UILabel?
    @IBOutlet weak var cocktailMeasurements: UILabel?
    @IBOutlet weak var recommendedSpirits: UIButton?
    @IBOutlet weak var cocktailLocation: UIButton?
    
    var cocktail : Cocktail!
    var fetchResultController: NSFetchedResultsController<Cocktail>!
    var sentName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cocktailName?.text = sentName
        //setupFetchedResultController()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadCocktailInformation() {
        
    }
    
//    func setupFetchedResultController() {
//        let fetchRequest : NSFetchRequest<Cocktail> = Cocktail.fetchRequest()
//        let prediate = NSPredicate(format: "cocktail == %@", cocktail)
//        fetchRequest.predicate = prediate
//        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
//    }
    
    //Add weather API and "should I go out" page?
    //https://stackoverflow.com/questions/35753949/swift-how-to-get-openweathermap-json-data
    

    @IBAction func findBar(_ sender: Any) {
    }
    
    @IBAction func findSpirits(_ sender: Any) {
    }
    
}
