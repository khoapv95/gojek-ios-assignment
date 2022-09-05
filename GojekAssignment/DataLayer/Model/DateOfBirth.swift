//
//  DateOfBirth.swift
//  GojekAssignment
//
//  Created by Khoa Pham on 05/09/2022.
//

import Foundation

public struct DateOfBirth: Equatable, Codable {
    
    // MARK: - Properties
    public let date: String
    public let age: Int
    
    // MARK: - Methods
    public init(date: String, age: Int) {
        self.date = date
        self.age = age
    }
}
