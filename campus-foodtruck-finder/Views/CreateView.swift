//
//  CreateView.swift
//  campus-foodtruck-finder
//
//  Created by 陈昱桦 on 2/15/25.
//

import SwiftUI
import CoreLocation

struct CreateView: View {
    @ObservedObject var viewModel: FoodTruckViewModel
    @ObservedObject var locationService: LocationManager

    @State private var name: String = ""
    @State private var hours: String = ""
    @State private var averagePrice: String = ""
    @State private var category: String = ""
    @State private var isFavorite: Bool = false
    @State private var latitude: CLLocationDegrees?
    @State private var longitude: CLLocationDegrees?
    @State private var showAlert = false
    @State private var alertMessage = ""
    @FocusState private var buttonIsFocused: Bool

    var body: some View {
        VStack {
            Form {
                Text("Create New Food Truck")
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .listRowBackground(Color(.systemGroupedBackground))
                
                Section() {
                    TextField("Name", text: $name)
                        .focused($buttonIsFocused)
                    TextField("Hours", text: $hours)
                        .focused($buttonIsFocused)
                    TextField("Average Price", text: $averagePrice)
                        .keyboardType(.decimalPad)
                        .focused($buttonIsFocused)
                    TextField("Category", text: $category)
                        .focused($buttonIsFocused)
                    HStack {
                        Text("Favorite")
                        Spacer()
                        Image(systemName: isFavorite ? "heart.fill" : "heart")
                            .foregroundColor(isFavorite ? .red : .gray)
                            .onTapGesture {
                                isFavorite.toggle()
                            }
                    }
                    if let latitude = latitude, let longitude = longitude {
                        Text("Latitude: \(latitude, specifier: "%.2f")")
                        Text("Longitude: \(longitude, specifier: "%.2f")")
                    } else {
                        Text("Fetching location...")
                    }
                }
                
                Button("Done") {
                    buttonIsFocused = false
                    if validateFields() {
                        if let averagePriceDouble = Double(averagePrice) {
                            let newLocation = CLLocation(latitude: latitude ?? 0, longitude: longitude ?? 0)
                            let newTruck = FoodTruck(name: name, location: newLocation, hours: hours, averagePrice: averagePriceDouble, category: category, isFavorite: isFavorite)
                            viewModel.addFoodTruck(newTruck)
                            
                            // Reset field values
                            name = ""
                            hours = ""
                            category = ""
                            averagePrice = ""
                            isFavorite = false
                            latitude = 0.0
                            longitude = 0.0
                            alertMessage = "Food Truck Created!"
                            showAlert = true
                        }
                    } else {
                        alertMessage = "Please fill in all required fields"
                        showAlert = true
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Notification"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        .tabItem {
            Label("Create", systemImage: "plus.circle.fill")
        }
        .onAppear {
            fetchUserLocation()
        }
    }
    
    // Validation function for form fields
    private func validateFields() -> Bool {
        return !name.isEmpty && !hours.isEmpty && !category.isEmpty && !averagePrice.isEmpty
    }
    
    private func fetchUserLocation() {
        // Ensure the location service is authorized and ready
        locationService.requestLocationPermission()
        
        // Asynchronously fetch the current location
        DispatchQueue.main.async {
            self.latitude = locationService.location?.coordinate.latitude
            self.longitude = locationService.location?.coordinate.longitude
        }
    }
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView(viewModel: FoodTruckViewModel(), locationService: LocationManager())
    }
}

