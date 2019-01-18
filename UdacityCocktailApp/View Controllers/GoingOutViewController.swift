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
    var currentWeatherLabel: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
        loadWeatherData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        decisionLabel.text = currentWeatherLabel
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
                        
                        let dataClient = DataClientWeather()
                        dataClient.getWeatherData(city: city)
                        self.currentWeatherLabel = dataClient.currentWeather
                    }
                })
                break
            case .notDetermined, .restricted, .denied:
                print("Error: Either Not Determined, Restricted, or Denied. ")
                break
            }
        }
    }
}
