//
//  Bird.swift
//  BirdWatch
//
//  Created by Vin Bui on 11/13/23.
//

import Foundation

struct Bird: Hashable {
    let name: String
    let location: String
    let image: String
    let count: Int
}

// Normally this would be in a ViewModel
var dummyData = [
    Bird(name: "Alden", location: "New Jersey", image: "alden", count: 2),
    Bird(name: "Antoinette", location: "New York", image: "antoinette", count: 6),
    Bird(name: "Elvis", location: "New Jersey", image: "elvis", count: 7),
    Bird(name: "Han", location: "Texas", image: "han", count: 1),
    Bird(name: "Jennifer", location: "California", image: "jennifer", count: 5),
    Bird(name: "Justin", location: "China", image: "justin", count: 8),
    Bird(name: "Reade", location: "Connecticut", image: "reade", count: 1),
    Bird(name: "Richie", location: "New York", image: "richie", count: 4),
    Bird(name: "Tiffany", location: "New York", image: "tiffany", count: 3),
    Bird(name: "Vin", location: "Texas", image: "vin", count: 7),
    Bird(name: "Vivian", location: "Unknown", image: "vivian", count: 1)
]
