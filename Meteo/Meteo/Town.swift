//
//  Town.swift
//  Meteo
//
//  Created by Maxime Haye on 13/11/2017.
//  Copyright © 2017 Maxime Haye. All rights reserved.
//

import UIKit
import SwiftyJSON

class Town: NSObject {
    
    var name: String
    var temperature: Int
    var localInformation: String
    
    init(json : JSON){
        print(json)
        let temp = json["main"]["temp"].int
        let local = json["weather"][0]["description"].string
        let name = json["name"].string
        
        self.name = name ?? ""
        self.temperature = temp ?? 0
        self.localInformation = local ?? ""
    }

}
