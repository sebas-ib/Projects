//
//  HomeView.swift
//  Travel Planner 2
//
//  Created by Sebastian Ibarra on 10/12/24.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background color
                Color("AccentColor")
                    .ignoresSafeArea() // Fill the entire background
                
                VStack {

                }

                // Custom Navigation Bar with NavigationLink
                NavigationBar(topNavBar: true,bottomNavBar: true, search:false,title: "", destination: AnyView(CountrySelectionView()))
            }
        }.navigationBarBackButtonHidden(true)
    }
}

#Preview {
    HomeView()
}

