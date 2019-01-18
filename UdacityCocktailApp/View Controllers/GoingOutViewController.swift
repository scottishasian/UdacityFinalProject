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
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    var locationManager: CLLocationManager = CLLocationManager()
    var userLocation: CLLocation!
    var apiKey = "7f5cf61e2a9e2510653f76d1061015b6"
    let openWeatherMapBaseURL = "http://api.openweathermap.org/data/2.5/weather"

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
        loadWeatherData()

    }
    
    func displayWeatherIcon() {
        
    }
    
    func loadWeatherData() {
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .authorizedAlways, .authorizedWhenInUse:
                print("Authorized.")
                let lat = locationManager.location?.coordinate.latitude
                let long = locationManager.location?.coordinate.longitude
                let location = CLLocation(latitude: lat!, longitude: long!)
                CLGeocoder().reverseGeocodeLocation(location, completionHandler: { (placemarks, error) in
                    if error != nil {
                        return
                    } else if let country = placemarks?.first?.country, let city = placemarks?.first?.locality {
                        print(country)
                        print(city)
                        self.getWeatherData(city: city)
                    }
                })
                break
            case .notDetermined, .restricted, .denied:
                print("Error: Either Not Determined, Restricted, or Denied. ")
                break
            }
        }
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
                do {
                    let weather: [String : AnyObject] = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : AnyObject]
                    performUIUpdatesOnMain {
                        self.weatherLabel.text = "The city is \(weather["name"]!) and the temperature is \(weather["main"]!["temp"] as! Double - 273.14) C."
                        self.temperatureLabel.text = "\(weather["main"]!["temp"] as! Double - 273.14) C."
                    }
                    
                    
                }
                catch let jsonError as NSError {
                    print("JSON error: \(jsonError.description)")
                }
            }
        }
        dataTask.resume()
    }
}
