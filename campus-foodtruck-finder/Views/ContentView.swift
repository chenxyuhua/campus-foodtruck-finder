//
//  ContentView.swift
//  campus-foodtruck-finder
//
//  Created by 陈昱桦 on 2/15/25.
//

import Foundation
import SwiftUI

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
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
