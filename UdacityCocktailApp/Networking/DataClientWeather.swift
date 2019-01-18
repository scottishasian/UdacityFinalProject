//
//  DataClientWeather.swift
//  UdacityCocktailApp
//
//  Created by Kynan Song on 18/01/2019.
//  Copyright © 2019 Kynan Song. All rights reserved.
//

import Foundation

class DataClientWeather {
    
    var apiKey = "7f5cf61e2a9e2510653f76d1061015b6"
    let openWeatherMapBaseURL = "http://api.openweathermap.org/data/2.5/weather"
    var currentWeather: String = ""
    
    func getWeatherData(city: String) {
        let session = URLSession.shared
        let weatherRequest = URL(string: "\(openWeatherMapBaseURL)?APPID=\(apiKey)&q=\(city)")
        
        let dataTask = session.dataTask(with: weatherRequest!) {
            (data, response, error) in
            
            if let error = error {
                print("\(error)")
            }
            else {
                //                let dataString = String(data: data!, encoding: String.Encoding.utf8)
                //                print("The weather in Edinburgh is: \(data) + \(dataString)")
                do {
                    let weather: [String : AnyObject] = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : AnyObject]
                    print("\(weather["name"] as? String)")
                    self.currentWeather = "The city is \(weather["name"]!) and the temperature is \(weather["main"]!["temp"] as! Double - 273.14) C."
                    print("\(self.currentWeather)")
                }
                catch let jsonError as NSError {
                    print("JSON error: \(jsonError.description)")
                }
            }
        }
        dataTask.resume()
    }
    
}
