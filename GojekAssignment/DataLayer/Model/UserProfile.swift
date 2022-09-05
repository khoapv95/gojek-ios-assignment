//
//  UserProfile.swift
//  GojekAssignment
//
//  Created by Khoa Pham on 05/09/2022.
//

import Foundation

public struct UserProfile: Equatable, Decodable {
    
    // MARK: - Properties
    public let name: Name
    public let dob: DateOfBirth
    public let location: Location
    public let mobileNumber: String
    
    // MARK: - Methods
    public init(name: Name,
                dob: DateOfBirth,
                location: Location,
                mobileNumber: String) {
        self.name = name
        self.dob = dob
        self.location = location
        self.mobileNumber = mobileNumber
    }
    
    enum CodingKeys: String, CodingKey {
      case name
      case dob
      case location
      case cell
    }

    public init(from decoder: Decoder) throws {
      let values = try decoder.container(keyedBy: CodingKeys.self)

      name =
        try values.decode(Name.self, forKey: .name)

      dob =
        try values.decode(DateOfBirth.self, forKey: .dob)
        
      location =
        try values.decode(Location.self, forKey: .location)

      mobileNumber =
        try values.decode(String.self, forKey: .cell)
    }
}

public struct UserResponse: Equatable, Decodable {
    
    // MARK: - Properties
    public let results: [UserProfile]
    
    // MARK: - Methods
    public init(results: [UserProfile]) {
        self.results = results
    }
}
