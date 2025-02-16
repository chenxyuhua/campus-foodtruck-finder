//
//  FoodTruck.swift
//  campus-foodtruck-finder
//
//  Created by 陈昱桦 on 2/15/25.
//

import Foundation
import CoreLocation

struct FoodTruck: Identifiable, Codable {
    var id: UUID
    var name: String
    var location: CLLocation
    var hours: String
    var averagePrice: Double
    var category: String
    var isFavorite: Bool

    enum CodingKeys: String, CodingKey {
        case id, name, latitude, longitude, hours, averagePrice, category, isFavorite
    }

    // Default initializer
    init(id: UUID = UUID(), name: String, location: CLLocation, hours: String, averagePrice: Double, category: String, isFavorite: Bool) {
        self.id = id
        self.name = name
        self.location = location
        self.hours = hours
        self.averagePrice = averagePrice
        self.category = category
        self.isFavorite = isFavorite
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        let latitude = try container.decode(CLLocationDegrees.self, forKey: .latitude)
        let longitude = try container.decode(CLLocationDegrees.self, forKey: .longitude)
        location = CLLocation(latitude: latitude, longitude: longitude)
        hours = try container.decode(String.self, forKey: .hours)
        averagePrice = try container.decode(Double.self, forKey: .averagePrice)
        category = try container.decode(String.self, forKey: .category)
        isFavorite = try container.decode(Bool.self, forKey: .isFavorite)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(location.coordinate.latitude, forKey: .latitude)
        try container.encode(location.coordinate.longitude, forKey: .longitude)
        try container.encode(hours, forKey: .hours)
        try container.encode(averagePrice, forKey: .averagePrice)
        try container.encode(category, forKey: .category)
        try container.encode(isFavorite, forKey: .isFavorite)
    }
}
