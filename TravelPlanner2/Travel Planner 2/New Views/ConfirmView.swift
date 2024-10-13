//
//  ConfirmView.swift
//  Travel Planner 2
//
//  Created by Sebastian Ibarra on 10/12/24.
//

import SwiftUI

struct ConfirmView: View {
    @Binding var selectedCountries : [String]
    
    var body: some View {
        NavigationStack{
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
                        NavigationLink(destination: CountrySelectionView()) {
                            HStack(alignment: .center, spacing: 2) {
                                Image(systemName: "chevron.left")
                                    .font(.title3)
                                    .foregroundStyle(Color("TextColor"))
                                Text("Back")
                                    .font(.title3)
                                    .foregroundStyle(Color("TextColor"))
                            }
                            .padding(.leading, 20.0)
                        }
                        
                        Spacer()
                        
                        Button(action:{
                            print(selectedCountries)
                            
                        }){
                            HStack(alignment: .center, spacing: 2){
                                Text("Next")
                                    .font(.title3)
                                    .foregroundStyle(Color("TextColor"))
                                
                                Image(systemName: "chevron.right").font(.title3).foregroundStyle(Color("TextColor"))
                            }.padding(.trailing, 20.0)
                        }
                    }.padding(.top).background(Color("HeaderFooterColor"))
                }
                .safeAreaInset(edge: .top){
                    Text("Selected Countries")
                        .font(.title)
                        .fontWeight(.light)
                        .foregroundColor(Color("TextColor"))
                        .padding(.bottom)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .background(Color("HeaderFooterColor"))
                }
                .navigationBarBackButtonHidden(true)
            }
        }

    }
}

