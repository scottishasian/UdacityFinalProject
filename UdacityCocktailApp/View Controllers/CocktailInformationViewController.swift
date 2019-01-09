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

    @IBOutlet weak var cocktailName: UILabel!
    @IBOutlet weak var cocktailInformation: UILabel!
    @IBOutlet weak var cocktailMeasurements: UILabel!
    @IBOutlet weak var recommendedSpirits: UIButton!
    @IBOutlet weak var cocktailLocation: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func findBar(_ sender: Any) {
    }
    
    @IBAction func findSpirits(_ sender: Any) {
    }
    
}
