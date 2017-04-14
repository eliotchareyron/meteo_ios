//
//  Meteo.swift
//  application_meteo
//
//  Created by etudiant on 13/04/2017.
//  Copyright © 2017 etudiant. All rights reserved.
//

import Foundation
class Meteo {
    var day : String
    var temp : NSNumber
    
    
    init(day : String, temp: NSNumber) {
        self.day = day
        self.temp = temp
    }
}
