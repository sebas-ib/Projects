//
//  Countries.swift
//  Travel Planner 2
//
//  Created by Sebastian Ibarra on 10/10/24.
//

import SwiftUI

struct Countries: Identifiable {
    let name: String
    var id = UUID()
}

struct CountryCoordinate {
    var name: String
    var latitude: Double
    var longitude: Double
}
