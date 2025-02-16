//
//  FoodTruckViewModel.swift
//  campus-foodtruck-finder
//
//  Created by 陈昱桦 on 2/15/25.
//

import Foundation
import Combine
import MapKit
import CoreLocation

class FoodTruckViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var foodTrucks: [FoodTruck] = []
    @Published var userLocation: CLLocationCoordinate2D?
    private var locationManager = CLLocationManager()
    
    override init() {
        super.init()
        loadFoodTrucks()
        self.locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    // Adds a new food truck
    func addFoodTruck(_ truck: FoodTruck) {
        foodTrucks.append(truck)
        saveFoodTrucks()
    }
    
    // Deletes a food truck
    func deleteFoodTruck(_ truck: FoodTruck) {
        if let index = foodTrucks.firstIndex(where: { $0.id == truck.id }) {
            foodTrucks.remove(at: index)
            saveFoodTrucks()
        }
    }
    
    // Saves food trucks to persistent storage
    func saveFoodTrucks() {
        if let data = try? JSONEncoder().encode(foodTrucks) {
            UserDefaults.standard.set(data, forKey: "FoodTrucks")
        }
    }

    // Loads food trucks from persistent storage
    func loadFoodTrucks() {
        if let data = UserDefaults.standard.data(forKey: "FoodTrucks"),
           let savedFoodTrucks = try? JSONDecoder().decode([FoodTruck].self, from: data) {
            foodTrucks = savedFoodTrucks
        }
    }
    
    func toggleFavorite(_ truck: FoodTruck) {
        if let index = foodTrucks.firstIndex(where: { $0.id == truck.id }) {
            foodTrucks[index].isFavorite.toggle()
            saveFoodTrucks()
        }
    }
    
}
