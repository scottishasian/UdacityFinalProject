//
//  Constants.swift
//  UdacityCocktailApp
//
//  Created by Kynan Song on 16/11/2018.
//  Copyright © 2018 Kynan Song. All rights reserved.
//

import Foundation

struct Constants {
    
    struct Udacity {
        static let APIScheme = "https"
        static let APIHost = "onthemap-api.udacity.com"
        static let APIPath = "/v1"
        static let SignUp = "https://auth.udacity.com/sign-up"
    }
    
    struct Parse {
        static let APIScheme = "https"
        static let APIHost = "parse.udacity.com"
        static let APIPath = "/parse"
    }
    
    struct ParseMethods {
        static let studentLocations = "/classes/StudentLocation"
    }
    
    struct ParseParameterKeys {
        static let Where = "where"
        static let restAPIKey = "X-Parse-REST-API-Key"
        static let parseID = "X-Parse-Application-Id"
        static let Order = "order"
    }
    
    struct ParseParameterValues {
        static let parseID = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
        static let restAPIKey = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
    }
    
    struct ParseJSONKeys {
        static let Results = "results"
    }
    
    struct UdacityMethods {
        static let SessionAuth = "/session"
        static let Users = "/users"
    }
    
    struct ErrorMessages {
        static let loginError = "Unable to login"
    }
    
    //Parsing session data
    
    struct UserSession: Codable {
        let account: Account?
        let session: Session?
    }
    
    struct Session: Codable {
        let id: String
        let expiration: String
    }
    
    struct Account: Codable {
        let registered: Bool
        let key: String
    }
    
    struct OpenWeather {
        static let weatherAPIKey = "7f5cf61e2a9e2510653f76d1061015b6"
        static let weatherBaseURL = "http://api.openweathermap.org/data/2.5/weather"
    }
    
}
