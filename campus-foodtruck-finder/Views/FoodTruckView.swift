//
//  FoodTruckView.swift
//  campus-foodtruck-finder
//
//  Created by 陈昱桦 on 2/15/25.
//

import SwiftUI
import CoreLocation

struct FoodTruckView: View {
    @ObservedObject var viewModel: FoodTruckViewModel
    @Environment(\.presentationMode) var presentationMode
    let foodTruck: FoodTruck

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 10) {
                Group {
                    HStack {
                        Text("Hours:")
                            .bold()
                        Text(foodTruck.hours)
                    }

                    HStack {
                        Text("Category:")
                            .bold()
                        Text(foodTruck.category)
                    }

                    HStack {
                        Text("Average Price:")
                            .bold()
                        Text("$\(foodTruck.averagePrice, specifier: "%.2f")")
                    }
                    
                    HStack {
                        Text("Favorite:")
                            .bold()
                        if foodTruck.isFavorite {
                            Image(systemName: "heart.fill")
                                .foregroundColor(.red)
                        } else {
                            Image(systemName: "heart")
                        }
                    }

                    HStack {
                        Text("Latitude:")
                            .bold()
                        Text("\(foodTruck.location.coordinate.latitude, specifier: "%.2f")")
                    }
                    
                    HStack {
                        Text("Longitude:")
                            .bold()
                        Text("\(foodTruck.location.coordinate.longitude, specifier: "%.2f")")
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        viewModel.deleteFoodTruck(foodTruck)
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Remove Food Truck")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                }
            }
            .padding([.leading, .top, .bottom])
            .navigationBarTitle(Text(foodTruck.name), displayMode: .inline)
        }
    }
}

// A mock FoodTruck instance for previews
extension FoodTruck {
    static var mock: FoodTruck {
        return FoodTruck(
            id: UUID(),
            name: "Liam's Kitchen",
            location: CLLocation(latitude: 0, longitude: 0),
            hours: "10AM - 8PM",
            averagePrice: 10,
            category: "Chinese",
            isFavorite: true
        )
    }
}

// Update the preview provider for FoodTruckView
struct FoodTruckView_Previews: PreviewProvider {
    static var previews: some View {
        FoodTruckView(viewModel: FoodTruckViewModel(), foodTruck: .mock)
    }
}
