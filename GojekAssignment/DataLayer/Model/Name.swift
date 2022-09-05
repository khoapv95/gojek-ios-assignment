//
//  Name.swift
//  GojekAssignment
//
//  Created by Khoa Pham on 05/09/2022.
//

import Foundation

public struct Name: Equatable, Codable {
    
    // MARK: - Properties
    public let title: String
    public let first: String
    public let last: String
    
    // MARK: - Methods
    public init(title: String, first: String, last: String) {
        self.title = title
        self.first = first
        self.last = last
    }
}
