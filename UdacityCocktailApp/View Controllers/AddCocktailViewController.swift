//
//  AddCocktailViewController.swift
//  UdacityCocktailApp
//
//  Created by Kynan Song on 06/01/2019.
//  Copyright © 2019 Kynan Song. All rights reserved.
//

import UIKit
import CoreData

class AddCocktailViewController: UIViewController {
    
    @IBOutlet weak var cocktailName: UITextField!
    @IBOutlet weak var ingredient1: UITextField!
    @IBOutlet weak var ingredient2: UITextField!
    @IBOutlet weak var ingredient3: UITextField!
    
    @IBOutlet weak var measurementsTextField: UITextView!
    @IBOutlet weak var cocktailInformationTextField: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
