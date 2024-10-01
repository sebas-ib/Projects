//
//  SelectedCountriesPage.swift
//  Travel Planner
//
//  Created by Sebastian Ibarra on 9/30/24.
//
import SwiftUI

struct SelectedCountriesPage: View {
    
    @State var selectedCountries: [String]  // Accept selected countries as a parameter
    @State private var showLastView: Bool = false
    @State private var showNextView: Bool = false
    @State private var fadeOutCurrentView: Bool = false
    
    var body: some View {
        ZStack{
            Color("AccentColor").ignoresSafeArea()
            ZStack {
                if showLastView {
                    CountrySelection(selectedCountries: selectedCountries)
                        .transition(.opacity)
                        .animation(.easeInOut, value: showLastView)
                } else if showNextView{
                    MapPage(selectedCountries: selectedCountries)
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
                Text("Selected Countries").font(.title).fontWeight(.thin)
                    .foregroundStyle(Color("TextColor"))
                List {
                    ForEach(selectedCountries, id: \.self) { country in
                        HStack {
                            Text(country)
                                .fontWeight(.thin)
                                .foregroundStyle(Color("TextColor"))
                            Spacer()
                            
                            // Checkmark with fading effect
                            Image(systemName: "line.3.horizontal").fontWeight(.thin)
                                .foregroundStyle(Color("TextColor"))

                        }.listRowBackground(Color.clear)
                    }.onMove { from, to in
                        selectedCountries.move(fromOffsets: from, toOffset: to)

                    }

                }
                .listStyle(.plain)
                
                
                HStack {
                    Group {
                        Button(action: {
                            withAnimation {
                                fadeOutCurrentView = true
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                withAnimation {
                                    showLastView = true
                                }
                            }
                        }) {
                            backLabel(isEnabled: true)
                        }
                        Spacer()
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

                    }
                    .padding(.all)
                }
                .padding()
            }.padding(.top, 75.0)
        }
        
    }
    private func backLabel(isEnabled: Bool) -> some View {
        HStack(alignment: .center) {
            Image(systemName: "chevron.left")
                .font(.title2)
                .fontWeight(.thin)
                .foregroundColor(isEnabled ? Color("TextColor") : Color.gray)
            Text("Back")
                .font(.title2)
                .fontWeight(.thin)
                .foregroundColor(isEnabled ? Color("TextColor") : Color.gray)
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
    SelectedCountriesPage(selectedCountries: ["Spain", "Germany", "Canada"])  // Preview with sample data
}
