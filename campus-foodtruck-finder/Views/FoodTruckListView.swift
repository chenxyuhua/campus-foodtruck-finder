//
//  FoodTruckListView.swift
//  campus-foodtruck-finder
//
//  Created by 陈昱桦 on 2/15/25.
//

import SwiftUI
import CoreLocation

struct FoodTruckListView: View {
    @ObservedObject var viewModel: FoodTruckViewModel
    @Binding var searchText: String
    var userLocation: CLLocation?

    var filteredAndSortedFoodTrucks: [FoodTruck] {
        let filteredTrucks = viewModel.foodTrucks.filter { truck in
            searchText.isEmpty || truck.name.localizedCaseInsensitiveContains(searchText)
        }
        
        if let userLocation = userLocation {
            return filteredTrucks.sorted {
                $0.location.distance(from: userLocation) < $1.location.distance(from: userLocation)
            }
        } else {
            return filteredTrucks
        }
    }

    var body: some View {
        NavigationView {
            List {
                ForEach (filteredAndSortedFoodTrucks) { truck in
                    NavigationLink(destination: FoodTruckView(viewModel: viewModel, foodTruck: truck)) {
                        FoodTruckRow(viewModel: viewModel, truck: truck)
                    }
                }
            }
        }
    }
}


struct FoodTruckListView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = FoodTruckViewModel()
        viewModel.foodTrucks = [
            FoodTruck(
                id: UUID(),
                name: "Tasty Truck",
                location: CLLocation(latitude: 35.6895, longitude: 139.6917),
                hours: "10am - 9pm",
                averagePrice: 8.50,
                category: "Japanese Cuisine",
                isFavorite: true
            ),
        ]

        let searchText = Binding.constant("")
        let userLocation = CLLocation(latitude: 34.0522, longitude: -118.2437)

        return FoodTruckListView(viewModel: viewModel, searchText: searchText, userLocation: userLocation)
            .previewLayout(.sizeThatFits)
    }
}

