//
//  User.swift
//  UdacityCocktailApp
//
//  Created by Kynan Song on 08/12/2018.
//  Copyright © 2018 Kynan Song. All rights reserved.
//

import Foundation

struct User: Codable {
    let name: String
    enum CodingKeys: String, CodingKey {
        case name = "username"
    }
}
