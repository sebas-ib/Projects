import SwiftUI

struct NavigationBar: View {
    let topNavBar: Bool
    let bottomNavBar: Bool
    let search: Bool
    
    let title: String
    let destination: AnyView // Use AnyView to allow flexibility
    
    @State private var searchText = ""
    @FocusState private var isSearching: Bool
    
    @Environment(\.presentationMode) var presentationMode // Access to presentation mode


    var body: some View {
        VStack {
            // Top Navigation Bar
            
            if topNavBar{
                HStack {
                    if title != "" {
                        Text(title)
                            .font(.title)
                            .foregroundColor(Color("TextColor"))
                        Spacer()
                    }
                    
                    if search {
                        HStack(alignment: .center){
                            Image(systemName: "magnifyingglass")
                                .foregroundStyle(Color("TextColor"))
                                .padding(.leading, 10)
                                .font(.title3)
                            
                            TextField("", text: $searchText)
                                .font(.headline)
                                .fontWeight(.light)
                                .frame(height: 40.0)
                                .focused($isSearching)
                            Spacer()
                            
                        }
                        .background(Color.black.opacity(0.3))
                        .cornerRadius(20)
                        .padding(.horizontal, 3)
                    }
                }
                .padding()
                .background(Color("HeaderFooterColor"))
            }

            Spacer() // Spacer to push content away
            
            // Bottom Navigation Bar
            if bottomNavBar {
                HStack {
                        HStack{
                            Spacer()
                            Image(systemName: "house")
                            Spacer()
                            
                            Image(systemName: "magnifyingglass")
                            Spacer()
                            NavigationLink(destination: destination) {
                                Image(systemName: "plus.circle")
                                    .font(.largeTitle)
                            }
                            Spacer()

                            Image(systemName: "bookmark")
                            Spacer()
                            
                            Image(systemName: "person")
                            Spacer()
                        }.foregroundStyle(Color("TextColor")).font(.title3)
                }
                .padding(.top)
                .background(Color("HeaderFooterColor"))
            }
        }
    }
}



#Preview {
    NavigationStack {
        NavigationBar(topNavBar:true,bottomNavBar:true,search:false,title: "Discover", destination: AnyView(HomeView()))
    }
}
