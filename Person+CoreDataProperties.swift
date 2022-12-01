//
//  Person+CoreDataProperties.swift
//  GojekAssignment
//
//  Created by Icebreaker on 28/11/2022.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var title: String?
    @NSManaged public var first: String?
    @NSManaged public var last: String?
    @NSManaged public var dob: String?
    @NSManaged public var country: String?
    @NSManaged public var mobileNumber: String?
    @NSManaged public var photoData: Data?

}

extension Person : Identifiable {

}
