//
//  Street.swift
//  GojekAssignment
//
//  Created by Khoa Pham on 05/09/2022.
//

import Foundation

public struct Street: Equatable, Codable {
    
    // MARK: - Properties
    public let number: Int
    public let name: String
    
    // MARK: - Methods
    public init(number: Int, name: String) {
        self.number = number
        self.name = name
    }
}
