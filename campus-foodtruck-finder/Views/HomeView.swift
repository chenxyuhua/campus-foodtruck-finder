//
//  HomeView.swift
//  campus-foodtruck-finder
//
//  Created by 陈昱桦 on 2/15/25.
//

import SwiftUI
import MapKit
import CoreLocation

struct HomeView: View {
    @ObservedObject var viewModel: FoodTruckViewModel
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.43, longitude: -122.18),
        span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
    )
    
    var body: some View {
        NavigationView {
            Map(coordinateRegion: $region, annotationItems: viewModel.foodTrucks) { truck in
                MapAnnotation(coordinate: truck.location.coordinate) {
                    NavigationLink(destination: FoodTruckView(viewModel: viewModel, foodTruck: truck)) {
                        VStack {
                            Image(systemName: "mappin")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 20)
                                .foregroundColor(.red)
                            
                            Text(truck.name)
                                .font(.caption)
                                .bold()
                                .foregroundColor(.blue)
                                .padding(5)
                                .background(Color.white.opacity(0.65))
                                .cornerRadius(10)
                                .shadow(radius: 3)
                                .overlay(RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.blue, lineWidth: 1))
                        }
                    }
                }
            }
            .ignoresSafeArea()
            .onAppear {
                viewModel.loadFoodTrucks()
            }
        }
        .onReceive(viewModel.$userLocation) { location in
           if let location = location {
               region.center = location
           }
       }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: FoodTruckViewModel())
    }
}
