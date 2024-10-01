//
//  CountrySelection.swift
//  Travel Planner
//
//  Created by Sebastian Ibarra on 9/30/24.
//
import SwiftUI

struct CountrySelection: View {

    let countries = [
        "United States", "Canada", "Mexico", "Germany", "France", "Italy",
        "Spain", "Japan", "China", "India", "Portugal", "Great Britain",
    ]

    @State var selectedCountries: [String] = []
    @State private var showNextView: Bool = false
    @State private var fadeOutCurrentView: Bool = false
    
    var body: some View {
        ZStack{
            Color("AccentColor").ignoresSafeArea()
            ZStack {
                if showNextView {
                    SelectedCountriesPage(selectedCountries: selectedCountries)
                        .transition(.opacity)
                        .animation(.easeInOut, value: showNextView)
                } else {
                    currentView
                        .opacity(fadeOutCurrentView ? 0 : 1)
                        .animation(.easeInOut, value: fadeOutCurrentView)
                }
            }
        }
    }

    var currentView: some View {
        ZStack {
            Color("AccentColor").ignoresSafeArea()
            VStack {
                Text("Select Your Destinations")
                    .font(.title)
                    .fontWeight(.thin)
                    .foregroundColor(Color("TextColor"))
                
                List(countries, id: \.self) { country in
                    Button(action: {
                        if selectedCountries.contains(country) {
                            selectedCountries.removeAll { $0 == country }
                        } else {
                            selectedCountries.append(country)
                        }
                    }) {
                        HStack {
                            Text(country)
                                .fontWeight(.thin)
                                .foregroundColor(Color("TextColor"))
                            Spacer()
                            
                            // Checkmark with fading effect
                            Image(systemName: "checkmark").fontWeight(.thin)
                                .foregroundColor(Color("TextColor"))
                                .opacity(selectedCountries.contains(country) ? 1 : 0)  // Fade in/out based on selection
                                .animation(.easeInOut, value: selectedCountries.contains(country))  // Trigger animation on selection change
                        }
                    }
                    .listRowBackground(Color.clear)
                }
                .listStyle(.plain)  // Use plain list style
                
                HStack {
                    Spacer() // Pushes the 'Next' button to the right
                    Group {
                        if !selectedCountries.isEmpty {
                            Button(action: {
                                withAnimation {
                                    fadeOutCurrentView = true
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    withAnimation {
                                        showNextView = true
                                    }
                                }
                            }) {
                                nextLabel(isEnabled: true)
                            }
                        } else {
                            nextLabel(isEnabled: false)
                        }
                    }
                    .padding(.all)
                }
                .padding()
            }
            .padding(.top, 75.0)
        }
    }
    
    private func nextLabel(isEnabled: Bool) -> some View {
        HStack(alignment: .center) {
            Text("Next")
                .font(.title2)
                .fontWeight(.thin)
                .foregroundColor(isEnabled ? Color("TextColor") : Color.gray)
            Image(systemName: "chevron.forward")
                .font(.title2)
                .fontWeight(.thin)
                .foregroundColor(isEnabled ? Color("TextColor") : Color.gray)
        }
    }
    
}

#Preview {
    CountrySelection()
}
