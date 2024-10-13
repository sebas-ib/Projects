//
//  Travel_Planner_2App.swift
//  Travel Planner 2
//
//  Created by Sebastian Ibarra on 10/9/24.
//

import SwiftUI

@main
struct Travel_Planner_2App: App {
    
    @StateObject private var appFlowCoordinator = AppFlowCoordinator()
    @State var selectedCountries: [String] = []
    
    var body: some Scene {
        WindowGroup {
            RootView(selectedCountries: selectedCountries)
                .environmentObject(appFlowCoordinator)
        }
    }
}
