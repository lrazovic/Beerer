//
//  BeerStruct.swift
//  Beerer
//
//  Created by Leonardo Razovic on 16/03/18.
//  Copyright © 2018 Leonardo Razovic. All rights reserved.
//

import Foundation
import UIKit

struct Beer {
    let beerName: String
    let beerVariety: String
    let beerDescription: String
    let beerTemp: Double
    let beerPercentage: Int
    let beerImage: UIImage

    init(name: String, variety: String, description: String, temp: Double, percentage: Int, image: UIImage){
        self.beerName = name
        self.beerVariety = variety
        self.beerDescription = description
        self.beerTemp = temp
        self.beerPercentage = percentage
        self.beerImage = image
    }
}
