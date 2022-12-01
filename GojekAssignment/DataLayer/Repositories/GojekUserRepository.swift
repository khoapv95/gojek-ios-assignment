//
//  GojekUserRepository.swift
//  GojekAssignment
//
//  Created by Khoa Pham on 05/09/2022.
//

import Foundation
import RxSwift

public class GojekUserRepository: UserRepository {
    
    // MARK: - Properties
    let remoteAPI: UserRemoteAPI
    let datastore: UserDataStore
    
    // MARK: - Methods
    public init(remoteAPI: UserRemoteAPI,
                datastore: UserDataStore) {
        self.remoteAPI = remoteAPI
        self.datastore = datastore
    }
    
    public func getUsers() -> Observable<[PersonResponse]> {
        return remoteAPI.getUsers()
    }
    
    public func getUsersOnDisk() -> Observable<[PersonResponse]> {
        return datastore.getUsers()
    }
    
    public func saveUserToDisk(_ user: PersonResponse) {
        datastore.save(user)
    }
}
