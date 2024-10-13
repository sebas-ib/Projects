//
//  OrderView.swift
//  Travel Planner 2
//
//  Created by Sebastian Ibarra on 10/9/24.
//

import SwiftUI
import MapKit

struct OrderView: View {
    @EnvironmentObject var appFlowCoordinator: AppFlowCoordinator
    
    @Binding var selectedCountries: [String]
    
    @State private var searchText = ""

    @FocusState private var isSearching: Bool
    


    var body: some View {
        
        ZStack {
            
            // Background Color
            Color("AccentColor").ignoresSafeArea()
            
            // Main VStack
            VStack(alignment: .center, spacing: 0.0) {
                // List of selectable countries
                List {
                    ForEach(selectedCountries, id: \.self) { country in
                        HStack {
                            Text(country)
                                .font(.headline)
                                .fontWeight(.light)
                                .foregroundColor(Color("TextColor"))
                            Spacer()
                            Image(systemName: "line.3.horizontal")
                                .font(.title3)
                                .fontWeight(.light)
                                .foregroundColor(Color("TextColor"))
                        }.listRowBackground(Color.black.opacity(0.1))
                    }.onMove { from, to in
                        selectedCountries.move(fromOffsets: from, toOffset: to)
                    }
                }.scrollContentBackground(.hidden)

                                
            }.safeAreaInset(edge: .bottom){
                HStack {
                        Button(action:{
                            appFlowCoordinator.showSelectorView()
                        }){
                            HStack(alignment: .center, spacing: 2){
                                Image(systemName: "chevron.left").font(.title3).foregroundStyle(Color("TextColor"))
                                Text("Back")
                                    .font(.title3)
                                    .foregroundStyle(Color("TextColor"))
    
                            }.padding(.leading, 20.0)
                        }
    
                        Spacer()
    
                        Button(action:{
                                appFlowCoordinator.showMapView()

                            
                        }){
                            HStack(alignment: .center, spacing: 2){
                                Text("Next")
                                    .font(.title3)
                                    .foregroundStyle(Color("TextColor"))
    
                                Image(systemName: "chevron.right").font(.title3).foregroundStyle(Color("TextColor"))
                            }.padding(.trailing, 20.0)
                        }
                    }.padding(.top).background(Color("HeaderFooterColor"))
            }.safeAreaInset(edge: .top){
                Text("Selected Countries")
                    .font(.title)
                    .fontWeight(.light)
                    .foregroundColor(Color("TextColor"))
                    .padding(.bottom)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(Color("HeaderFooterColor"))
            }
        }
    }
}

struct OrderView_Previews: PreviewProvider {
    @State static var selectedCountries: [String] = ["Germany","France","Spain"]

    static var previews: some View {
        RootView(selectedCountries: selectedCountries)  // Pass the binding using $
            .environmentObject(AppFlowCoordinator())  // Provide the environment object here
    }
}
