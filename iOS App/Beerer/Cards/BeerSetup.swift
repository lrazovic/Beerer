//
//  BeerSetup.swift
//  Beerer
//
//  Created by Leonardo Razovic on 08/03/2018.
//  Copyright © 2018 Leonardo Razovic. All rights reserved.
//

struct beerSetup: Codable {
    var userId: String
    var beerValue: [Int]
    
    mutating func appenValue(value: Int) {
        beerValue.append(value)
    }

    mutating func setId(value: String) {
        userId = value
    }
    
    func countBeer() -> Int {
        return beerValue.count
    }
}
