//
//  ContentView.swift
//  campus-foodtruck-finder
//
//  Created by 陈昱桦 on 2/15/25.
//

import Foundation
import SwiftUI

struct ContentView: View {
    @ObservedObject var foodTruckViewModel = FoodTruckViewModel()
    @ObservedObject var locationManager = LocationManager()
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.white
    }
    
    var body: some View {
        TabView {
            HomeView(viewModel: foodTruckViewModel)
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            SearchView(viewModel: foodTruckViewModel)
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
        
            FavoritesView(viewModel: foodTruckViewModel)
                            .tabItem {
                                Label("Favorites", systemImage: "star.fill")
                            }
            
            CreateView(viewModel: foodTruckViewModel, locationService: locationManager)
                .tabItem {
                    Label("Add", systemImage: "plus.circle.fill")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
