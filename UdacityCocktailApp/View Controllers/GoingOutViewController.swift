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
    @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
    
    var locationManager: CLLocationManager = CLLocationManager()
    var userLocation: CLLocation!
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    var apiKey = Constants.OpenWeather.weatherAPIKey
    let openWeatherMapBaseURL = Constants.OpenWeather.weatherBaseURL

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
        loadingSpinner.startAnimating()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .authorizedAlways, .authorizedWhenInUse:
                print("Authorised.")
                
                if let lat = manager.location?.coordinate.latitude, let long = manager.location?.coordinate.longitude {
                    let location = CLLocation(latitude: lat, longitude: long)
                    print(location)
                    userLocation = location
                    
                    CLGeocoder().reverseGeocodeLocation(userLocation, completionHandler: { (placemarks, error) in
                        if error != nil {
                            self.showInfo(withMessage: "\(error)")
                            return
                        } else if let country = placemarks?.first?.country, let city = placemarks?.first?.locality {
                            print(country)
                            print(city)
                            self.getWeatherData(city: city)
                            self.loadingSpinner.stopAnimating()
                            self.loadingSpinner.isHidden = true
                        }
                    })
                }
                
                break
            case .notDetermined, .restricted, .denied:
                print("Error: Either Not Determined, Restricted, or Denied. ")
                break
            }
        }
    }
    
    
    func getWeatherData(city: String) {
        let session = URLSession.shared
        let weatherLocation = city.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) as! String
        let weatherRequest = URL(string: "\(openWeatherMapBaseURL)?APPID=\(apiKey)&q=\(weatherLocation)")
        let dataTask = session.dataTask(with: weatherRequest!) {
            (data, response, error) in
            
            if let error = error {
                debugPrint("\(error)")
            }
            else {
                do {
                    let weather: [String : AnyObject] = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : AnyObject]
                    performUIUpdatesOnMain {
                        self.weatherLabel.text = "You are in \(weather["name"]!)"
                        let temp = (weather["main"]!["temp"] as! Double - 273.14)
                        let labelText = String(format: "%.2f", temp)
                        self.temperatureLabel.text = "Temperature: \(labelText) °C"
                        self.displayWeatherIcon(temperature: temp)
                       
                    }

                }
                catch let jsonError as NSError {
                    print("JSON error: \(jsonError.description)")
                }
            }
        }
        dataTask.resume()
    }
    
    //https://www.flaticon.com/free-icon/snowflake_1200430
    
    func displayWeatherIcon(temperature: Double) {
        if temperature <= 10 {
            weatherView.image = UIImage(named: "snowflake")
        } else if temperature >= 10 && temperature <= 20 {
            weatherView.image = UIImage(named: "sun")
        } else {
            weatherView.image = UIImage(named: "sunny")
        }
        
    }
}
