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
    var currentWeather: String = ""
    var apiKey = "7f5cf61e2a9e2510653f76d1061015b6"
    let openWeatherMapBaseURL = "http://api.openweathermap.org/data/2.5/weather"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getWeatherData(city: "Edinburgh")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        decisionLabel.text = currentWeather
    }
    
    
    func getWeatherData(city: String) {
        let session = URLSession.shared
        let weatherRequest = URL(string: "\(openWeatherMapBaseURL)?APPID=\(apiKey)&q=\(city)")
        
        let dataTask = session.dataTask(with: weatherRequest!) {
            (data, response, error) in
            
            if let error = error {
                print("\(error)")
            }
            else {
                let dataString = String(data: data!, encoding: String.Encoding.utf8)
                print("The weather in Edinburgh is: \(data) + \(dataString)")
                
                do {
                    let weather: [String : AnyObject] = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : AnyObject]
                    //self.currentWeather = "Weather data for \(weather["name"]!)"
                    print("Weather data for \((weather["weather"]![0]! as! [String: AnyObject])["main"]!)")
                }
                catch let jsonError as NSError {
                    print("JSON error: \(jsonError.description)")
                }
            }
        }
        dataTask.resume()
    }
    
    

    

}
