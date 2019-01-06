//
//  GCDBlackBox.swift
//  UdacityCocktailApp
//
//  Created by Kynan Song on 06/01/2019.
//  Copyright © 2019 Kynan Song. All rights reserved.
//

import Foundation

func performUIUpdatesOnMain(_ updates: @escaping () -> Void) {
    DispatchQueue.main.async {
        updates()
    }
}
