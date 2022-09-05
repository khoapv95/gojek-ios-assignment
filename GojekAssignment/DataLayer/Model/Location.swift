//
//  Location.swift
//  GojekAssignment
//
//  Created by Khoa Pham on 05/09/2022.
//

import Foundation

public struct Location: Equatable, Codable {
    
    // MARK: - Properties
    public let street: Street
    public let city: String
    public let country: String
    
    // MARK: - Methods
    public init(street: Street, city: String, country: String) {
        self.street = street
        self.city = city
        self.country = country
    }
}
