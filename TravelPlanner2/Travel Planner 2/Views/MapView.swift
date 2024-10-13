//
//  MapView.swift
//  Travel Planner 2
//
//  Created by Sebastian Ibarra on 10/10/24.
//

import SwiftUI
import MapKit

struct MapView: View {
    @EnvironmentObject var appFlowCoordinator: AppFlowCoordinator

    @Binding var selectedCountries: [String]

    @State private var coordinates: [CountryCoordinate?] = []
    @State private var currentCountry: CLLocationCoordinate2D?
    @State var camera: MapCameraPosition = .automatic

    var body: some View {
        VStack {
            Map(position: $camera)
                .onAppear {
                    coordinates = Array(repeating: nil, count: selectedCountries.count)
                    let dispatchGroup = DispatchGroup()
                    
                    for (index, country) in selectedCountries.enumerated() {
                        dispatchGroup.enter()
                        print("Fetching coordinates for \(country)")
                        getCountryCoordinates(countryName: country, index: index) {
                            print("Completed fetching for \(country)")
                            dispatchGroup.leave() // Ensure leave is always called
                        }
                    }
                                            
                    dispatchGroup.notify(queue: .main) {
                        print("All coordinates fetched:")
                        print(coordinates)
                        // Updating the map
                        
                        
                        currentCountry = CLLocationCoordinate2D(latitude: coordinates[0]?.latitude ?? 0, longitude: coordinates[0]?.longitude ?? 0)
                        camera = .region(MKCoordinateRegion(center: currentCountry!, latitudinalMeters: 100000, longitudinalMeters: 100000))
                        
                        
                    }
                }
        }
        .safeAreaInset(edge: .bottom) {
            // Navigation buttons
            HStack {
                Button(action: {
                    appFlowCoordinator.showOrderView()
                }) {
                    HStack(alignment: .center, spacing: 2) {
                        Image(systemName: "chevron.left").font(.title3).foregroundStyle(Color("TextColor"))
                        Text("Back")
                            .font(.title3)
                            .foregroundStyle(Color("TextColor"))
                    }
                    .padding(.leading, 20.0)
                }

                Spacer()

                Button(action: {
                    print(coordinates)
                }) {
                    HStack(alignment: .center, spacing: 2) {
                        Text("Next")
                            .font(.title3)
                            .foregroundStyle(Color("TextColor"))
                        Image(systemName: "chevron.right").font(.title3).foregroundStyle(Color("TextColor"))
                    }
                    .padding(.trailing, 20.0)
                }
            }
            .padding(.top)
            .background(.ultraThinMaterial)
        }
        .safeAreaInset(edge: .top) {
            Text("Select Cities")
                .font(.title)
                .fontWeight(.light)
                .foregroundColor(Color("TextColor"))
                .padding(.bottom)
                .frame(maxWidth: .infinity, alignment: .center)
                .background(.ultraThinMaterial)
        }
    }

    func getCountryCoordinates(countryName: String, index: Int, completion: @escaping () -> Void) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = countryName

        let search = MKLocalSearch(request: searchRequest)
        search.start { response, error in
            guard let response = response, error == nil else {
                print("Error finding coordinates: \(error?.localizedDescription ?? "Unknown error")")
                completion()
                return
            }

            // Get the first matching item
            if let item = response.mapItems.first {
                let newCoordinate = CountryCoordinate(name: countryName, latitude: item.placemark.coordinate.latitude, longitude: item.placemark.coordinate.longitude)
                DispatchQueue.main.async {
                    coordinates[index] = newCoordinate
                    completion()
                }
            }else {
                completion()
            }
        }
    }
}



struct MapView_Previews: PreviewProvider {
    @State static var selectedCountries: [String] = ["Germany","France","Spain"]

    static var previews: some View {
        MapView(selectedCountries: $selectedCountries)  // Pass the binding using $
            .environmentObject(AppFlowCoordinator())  // Provide the environment object here
    }
}
