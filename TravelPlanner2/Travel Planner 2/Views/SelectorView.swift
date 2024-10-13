//
//  SelectorView.swift
//  Travel Planner 2
//
//  Created by Sebastian Ibarra on 10/9/24.
//

import SwiftUI

private var countries = [
    Countries(name: "France"),
    Countries(name: "Mexico"),
    Countries(name: "Spain"),
    Countries(name: "Turkey"),
    Countries(name: "Italy"),
    Countries(name: "United States"),
    Countries(name: "Greece"),
    Countries(name: "Austria"),
    Countries(name: "Germany"),
    Countries(name: "United Arab Emirates"),
    Countries(name: "Croatia"),
    Countries(name: "Poland"),
    Countries(name: "Hungary"),
    Countries(name: "Denmark"),
    Countries(name: "India"),
    Countries(name: "Portugal"),
    Countries(name: "United Kingdom"),
    Countries(name: "Netherlands"),
    Countries(name: "Albania"),
    Countries(name: "Dominican Republic"),
    Countries(name: "Switzerland"),
    Countries(name: "Ukraine"),
    Countries(name: "Morocco"),
    Countries(name: "Macao"),
    Countries(name: "Saudi Arabia"),
    Countries(name: "Belgium"),
    Countries(name: "Canada"),
    Countries(name: "Sweden"),
    Countries(name: "Puerto Rico"),
    Countries(name: "Tunisia"),
    Countries(name: "Bulgaria"),
    Countries(name: "South Africa"),
    Countries(name: "Bahrain"),
    Countries(name: "Colombia"),
    Countries(name: "Jordan"),
    Countries(name: "Andorra"),
    Countries(name: "Cyprus"),
    Countries(name: "Slovenia"),
    Countries(name: "Georgia"),
    Countries(name: "Montenegro"),
    Countries(name: "Indonesia"),
    Countries(name: "Norway"),
    Countries(name: "Iran"),
    Countries(name: "Finland"),
    Countries(name: "Luxembourg"),
    Countries(name: "Brazil"),
    Countries(name: "Nigeria"),
    Countries(name: "Thailand"),
    Countries(name: "Singapore"),
    Countries(name: "New Zealand"),
    Countries(name: "Cambodia"),
    Countries(name: "Philippines"),
    Countries(name: "Nepal"),
    Countries(name: "Australia"),
    Countries(name: "Bangladesh"),
    Countries(name: "Malaysia"),
    Countries(name: "Hong Kong"),
    Countries(name: "Bermuda"),
]

struct SelectorView: View {
    @EnvironmentObject var appFlowCoordinator: AppFlowCoordinator
    

    @Binding var selectedCountries: [String]
    @State private var searchText = ""
    @FocusState private var isSearching: Bool

    var body: some View {
        
        ZStack {
            Color("AccentColor").ignoresSafeArea()
            // Background Color
            
            

            
            // Main VStack
            VStack(alignment: .center, spacing: 0.0) {
                // List of selectable countries
                List(filteredCountries){ country in
                    Button(action: {
                        if selectedCountries.contains(country.name) {
                            selectedCountries.removeAll { $0 == country.name }
                            print("removed " + country.name)

                        } else {
                            selectedCountries.append(country.name)
                            print("added " + country.name)
                            
                        }
                    }){
                        HStack{
                            Text(country.name)
                                .font(.headline)
                                .fontWeight(.light)
                                .foregroundColor(Color("TextColor"))
                            Spacer()
                            
                            Image(systemName: "checkmark")
                                .font(.title3)
                                .fontWeight(.light)
                                .foregroundColor(Color("TextColor"))
                                .opacity(selectedCountries.contains(country.name) ? 1 : 0)
                                .animation(.easeInOut(duration: 0.3), value: selectedCountries.contains(country.name))
                        }
                    }
                    .listRowBackground(Color.black.opacity(0.1))
                }.scrollContentBackground(.hidden).foregroundStyle(Color("AccentColor"))
            }.safeAreaInset(edge: .bottom) {
                // Next button: Shows OrderView
                HStack{
                    Spacer()
                    Button(action:{
                        appFlowCoordinator.showOrderView()
                        print(selectedCountries)
                        
                    }){
                        HStack(alignment: .center, spacing: 2){
                            Text("Next")
                                .font(.title3)
                                .foregroundStyle(Color("TextColor"))
                            Image(systemName: "chevron.right").font(.title3).foregroundStyle(Color("TextColor"))
                        }.padding(.trailing, 20.0)
                    }
                }
                .padding(.top)
                .background(Color("HeaderFooterColor"))
            }
            .safeAreaInset(edge: .top) {
                // Next button: Shows OrderView
                VStack{
                    Text("Select Your Destinations")
                        .font(.title)
                        .fontWeight(.light)
                        .foregroundColor(Color("TextColor"))
                        .opacity(isSearching ? 0 : 1)
                        .animation(.easeInOut(duration: 0.3), value: isSearching)
                    
                    // Search bar
                    HStack(alignment: .center){
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(Color("TextColor"))
                            .padding(.leading, 10)
                        TextField("Search", text: $searchText)
                            .font(.headline)
                            .fontWeight(.light)
                            .frame(height: 30.0)
                            .focused($isSearching)
                        
                    }
                    .background(Color.black.opacity(0.3))
                    .cornerRadius(10)
                    .padding(.horizontal, 20)

                }
                .padding(.bottom)
                .background(Color("HeaderFooterColor"))
            }
        }
    }
    
    // Filtering countries based on search input
    var filteredCountries: [Countries] {
        if searchText.isEmpty {
            return countries
        } else {
            return countries.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
}

struct SelectorView_Previews: PreviewProvider {
    @State static var selectedCountries: [String] = ["Germany","France","Spain"]

    static var previews: some View {
        SelectorView(selectedCountries: $selectedCountries)  // Pass the binding using $
            .environmentObject(AppFlowCoordinator())  // Provide the environment object here
    }
}
