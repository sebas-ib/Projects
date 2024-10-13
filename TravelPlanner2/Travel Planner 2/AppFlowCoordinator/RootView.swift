//
//  RootView.swift
//  Travel Planner 2
//
//  Created by Sebastian Ibarra on 10/9/24.
//

import SwiftUI

struct RootView: View {
    @State var selectedCountries: [String]
    
    @EnvironmentObject var appFlowCoordinator: AppFlowCoordinator
    
    @ViewBuilder
    var body: some View {
        ZStack{
            Color("AccentColor").ignoresSafeArea()

            ZStack {
                if appFlowCoordinator.activeFlow == .selectorview {
                    SelectorView(selectedCountries: $selectedCountries)
                        .transition(.opacity)
                } else if appFlowCoordinator.activeFlow == .orderview {
                    OrderView(selectedCountries: $selectedCountries)
                        .transition(.opacity)
                } else if appFlowCoordinator.activeFlow == .mapview {
                    MapView(selectedCountries: $selectedCountries)
                    
                } else if appFlowCoordinator.activeFlow == .loadingview {
                    LoadingView()
                }else {
                    EmptyView()
                }
            }.onAppear(){
                print("Here: " , selectedCountries)
            }
        }
    }
}

#Preview {
    RootView(selectedCountries: ["Germany","Spain","France"]).environmentObject(AppFlowCoordinator())
}
