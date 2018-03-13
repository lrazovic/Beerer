//
//  BeerSetup.swift
//  Beerer
//
//  Created by Leonardo Razovic on 08/03/2018.
//  Copyright © 2018 Leonardo Razovic. All rights reserved.
//

struct beerSetup: Codable {
    let userId: String
    var beerValue: [Int]
    
    mutating func appenValue(value: Int) {
        beerValue.append(value)
    }
    
    func countBeer() -> Int {
        return beerValue.count
    }
}
