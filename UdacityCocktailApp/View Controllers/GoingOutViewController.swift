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
        getWeatherData(urlString: "api.openweathermap.org/data/2.5/weather?q=Edinburgh")
    }

    func getWeatherData(urlString: String) {
        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            
//            DispatchQueue.async(DispatchQueue.main(), {
//                self.setLabel(weatherData: data as! NSData)
//            })
            
        }
        
    }
    
    func setLabel(weatherData: NSData) {
        
    }

}
