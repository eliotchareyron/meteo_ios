//
//  Ville.swift
//  application_meteo
//
//  Created by etudiant on 11/04/2017.
//  Copyright © 2017 etudiant. All rights reserved.
//

import Foundation
class Ville {
    var id: NSNumber = 0
    var name: String = ""
    var temperature: NSNumber = 0
    var pression: NSNumber = 0
    var humidite: NSNumber = 0
    var tempmax : NSNumber = 0
    var tempmin : NSNumber = 0
    var icon :  String = ""
    
    init(id:NSNumber, name: String ,temperature: NSNumber , pression: NSNumber ,humidite: NSNumber , tempmax : NSNumber, tempmin : NSNumber, icon : String ) {
        self.id = id
        self.temperature = temperature
        self.name = name
        self.humidite = humidite
        self.pression = pression
        self.tempmax = tempmax
        self.tempmin = tempmin
        self.icon = icon
    }
    
    
}
