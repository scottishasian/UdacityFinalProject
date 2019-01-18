//
//  DataClientWeather.swift
//  UdacityCocktailApp
//
//  Created by Kynan Song on 18/01/2019.
//  Copyright © 2019 Kynan Song. All rights reserved.
//

import Foundation

class DataClientWeather: NSObject {
    
    var apiKey = "7f5cf61e2a9e2510653f76d1061015b6"
    let openWeatherMapBaseURL = "http://api.openweathermap.org/data/2.5/weather"
    var currentWeather: String = ""
    var currentTemperature: String = ""
    
    class func sharedInstance() -> DataClientWeather {
        struct SingletonClass {
            static var sharedInstance = DataClientWeather()
        }
        return SingletonClass.sharedInstance
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
                    self.currentWeather = "The city is \(weather["name"]!) and the temperature is \(weather["main"]!["temp"] as! Double - 273.14) C."
                    self.currentTemperature = "\(weather["main"]!["temp"] as! Double - 273.14) C."
                }
                catch let jsonError as NSError {
                    print("JSON error: \(jsonError.description)")
                }
            }
        }
        dataTask.resume()
    }
    
}
