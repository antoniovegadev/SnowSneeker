//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Antonio Vega on 8/19/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var favorites = Favorites()
    
    @State private var sort: SortType = .Default
    @State private var filter = Filter()
    
    @State private var isShowingSortMenu = false
    @State private var isShowingFilterMenu = false
    
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    var resortsSortedFiltered: [Resort] {
        var ret: [Resort] = []
        
        switch sort {
        case .Default:
            ret = self.resorts
        case .alphabetical:
            ret = self.resorts.sorted(by: \.name)
        case .country:
            ret = self.resorts.sorted(by: \.country)
        }
        
        if filter.country != nil {
            ret = ret.filter { $0.country == filter.country }
        }
        
        if filter.size != nil {
            ret = ret.filter { $0.size == filter.size }
        }
        
        if filter.price != nil {
            ret = ret.filter { $0.price == filter.price }
        }
        
        return ret
    }

    var body: some View {
        NavigationView {
            List(resortsSortedFiltered) { resort in
                NavigationLink(destination: ResortView(resort: resort)) {
                    Image(resort.country)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 25)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 5)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.black, lineWidth: 1)
                        )
                    
                    VStack(alignment: .leading) {
                        Text(resort.name)
                            .font(.headline)
                        Text("\(resort.runs) runs")
                            .foregroundColor(.secondary)
                    }
                    .layoutPriority(1)
                }
                
                if self.favorites.contains(resort) {
                    Spacer()
                    Image(systemName: "heart.fill")
                    .accessibility(label: Text("This is a favorite resort"))
                    .foregroundColor(.red)
                }
            }
            .navigationBarTitle("Resorts")
            .navigationBarItems(leading: Button(action: { isShowingFilterMenu = true }) {
                Image(systemName: "line.horizontal.3.decrease.circle")
            }, trailing: Button(action: { isShowingSortMenu = true }) {
                Image(systemName: "arrow.up.arrow.down.circle")
            })
            .actionSheet(isPresented: $isShowingSortMenu) {
                ActionSheet(title: Text("Select sort"), message: nil, buttons: [
                    .default(
                        Text("Default"),
                        action: { sort = .Default }
                    ),
                    .default(
                        Text("Alphabetical"),
                        action: { sort = .alphabetical }
                    ),
                    .default(
                        Text("Country"),
                        action: { sort = .country }
                    )
                ])
            }
            .sheet(isPresented: $isShowingFilterMenu) {
                FilterSelectionView(filter: $filter)
            }
            
            WelcomeView()
        }
        .environmentObject(favorites)
        .phoneOnlyStackNavigationView()
    }
}

extension ContentView {
    enum SortType: String {
        case Default = "Default"
        case alphabetical = "Alphabetical"
        case country = "Country"
    }
}

extension View {
    func phoneOnlyStackNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return AnyView(self.navigationViewStyle(StackNavigationViewStyle()))
        } else {
            return AnyView(self)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
