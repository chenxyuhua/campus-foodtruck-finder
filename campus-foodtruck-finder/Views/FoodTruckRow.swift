//
//  FoodTruckRow.swift
//  campus-foodtruck-finder
//
//  Created by 陈昱桦 on 2/15/25.
//

import SwiftUI
import CoreLocation

struct FoodTruckRow: View {
    @ObservedObject var viewModel: FoodTruckViewModel
    let truck: FoodTruck
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(truck.name).font(.headline)
            }
            Spacer()
            Image(systemName: truck.isFavorite ? "heart.fill" : "heart")
                .foregroundColor(truck.isFavorite ? .red : .gray)
                .onTapGesture {
                    viewModel.toggleFavorite(truck)
                }
        }
    }
}

struct FoodTruckRow_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = FoodTruckViewModel()

        viewModel.foodTrucks.append(FoodTruck(
            name: "Tasty Truck",
            location: CLLocation(latitude: 35.6895, longitude: 139.6917),
            hours: "10am - 9pm",
            averagePrice: 8.50,
            category: "Japanese Cuisine",
            isFavorite: true
        ))

        // Return a FoodTruckRow view if a sample truck is available, otherwise return a placeholder Text view.
        return Group {
            if let sampleTruck = viewModel.foodTrucks.first {
                FoodTruckRow(viewModel: viewModel, truck: sampleTruck)
            } else {
                Text("No food trucks available for preview.")
            }
        }
        .previewLayout(.sizeThatFits)
    }
}
