//
//  Photo.swift
//  GojekAssignment
//
//  Created by Khoa Pham on 06/09/2022.
//

import Foundation

public struct Photo: Equatable, Codable {
    
    // MARK: - Properties
    public let large: String
    
    // MARK: - Methods
    public init(large: String) {
        self.large = large
    }
}
