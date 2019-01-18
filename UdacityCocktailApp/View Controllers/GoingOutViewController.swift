//
//  GoingOutViewController.swift
//  UdacityCocktailApp
//
//  Created by Kynan Song on 18/01/2019.
//  Copyright © 2019 Kynan Song. All rights reserved.
//

import UIKit
import CoreLocation

class GoingOutViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var weatherView: UIImageView!
    @IBOutlet weak var decisionLabel: UILabel!
    
    var locationManager: CLLocationManager = CLLocationManager()
    var userLocation: CLLocation!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let currentLocation: AnyObject = locations[locations.count - 1]
        
        let latitude = currentLocation.coordinate.latitude
        let longitude = currentLocation.coordinate.longitude
        let appID = 2141424 //TODO
        
        let urlPath = "http://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(appID)"
        let url = NSURL(string: urlPath)
    }

}
