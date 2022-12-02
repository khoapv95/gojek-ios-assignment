//
//  UserDataStore.swift
//  GojekAssignment
//
//  Created by Icebreaker on 29/11/2022.
//

import Foundation
import RxSwift
import CoreData

public class PersonResponse {
    var title: String?
    var first: String?
    var last: String?
    var dob: String?
    var country: String?
    var mobileNumber: String?
    var photoData: Data?
    var photoURLString: String?
    var isFavorite: Bool = false
}


public protocol UserDataStore {

    func getUsers() -> Observable<[PersonResponse]>
    func save(_ user: PersonResponse)
}

public class UserDataStoreInDisk: UserDataStore {
    
    // MARK: - Properties
    var managedContext: NSManagedObjectContext!
    
    init() {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        managedContext = appDelegate?.persistentContainer.viewContext
    }
    
    public func getUsers() -> Observable<[PersonResponse]> {
        
        return Observable.create { observer in
            
            let request: NSFetchRequest<Person> = Person.fetchRequest()
            do {
                let records = try self.managedContext.fetch(request)
                var results = [PersonResponse]()
                for item in records {
                    let person = PersonResponse()
                    person.title = item.title
                    person.first = item.first
                    person.last = item.last
                    person.dob = item.dob
                    person.country = item.country
                    person.mobileNumber = item.mobileNumber
                    person.photoData = item.photoData
                    person.isFavorite = true
                    results.append(person)
                }
                observer.onNext(results)
                observer.onCompleted()
            } catch let error as NSError {
                print("Could not fetch \(error), \(error.userInfo)")
                observer.onError(error)
            }
            
            return Disposables.create()
        }
        
    }
    
    public func save(_ user: PersonResponse) {
        let request: NSFetchRequest<Person> = Person.fetchRequest()
        request.predicate = NSPredicate(format: "%K = %@", argumentArray: [#keyPath(Person.mobileNumber), user.mobileNumber ?? ""])
        do {
            let results = try managedContext.fetch(request)
            if results.isEmpty {
                let entity = NSEntityDescription.entity(forEntityName: "Person", in: managedContext)!
                let person = Person(entity: entity, insertInto: managedContext)
                person.title = user.title
                person.first = user.first
                person.last = user.last
                person.dob = user.dob
                person.country = user.country
                person.mobileNumber = user.mobileNumber
                person.photoData = user.photoData
                try? managedContext.save()
            } else {
                print("User already exists in the database")
            }
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
}
