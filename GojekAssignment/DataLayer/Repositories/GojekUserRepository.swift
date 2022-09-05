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
    
    // MARK: - Methods
    public init(remoteAPI: UserRemoteAPI) {
        self.remoteAPI = remoteAPI
    }
    
    public func getUsers() -> Observable<UserResponse> {
        return remoteAPI.getUsers()
    }
}
