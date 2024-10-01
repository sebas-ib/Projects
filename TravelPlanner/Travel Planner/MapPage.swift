//
//  MapPage.swift
//  Travel Planner
//
//  Created by Sebastian Ibarra on 10/1/24.
//

import SwiftUI
import MapKit

struct MapPage: View{
    @State var selectedCountries: [String]
    
    
    
    var body: some View {
        Map()
    }
    
}


#Preview {
    MapPage(selectedCountries: ["Spain", "Germany", "Canada"])
}
