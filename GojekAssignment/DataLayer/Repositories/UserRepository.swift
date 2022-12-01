//
//  UserRepository.swift
//  GojekAssignment
//
//  Created by Khoa Pham on 05/09/2022.
//

import Foundation
import RxSwift

public protocol UserRepository {
  
    func getUsers() -> Observable<[PersonResponse]>
    func getUsersOnDisk() -> Observable<[PersonResponse]>
    func saveUserToDisk(_ user: PersonResponse)
}
