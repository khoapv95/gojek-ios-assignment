//
//  UserRemoteAPI.swift
//  GojekAssignment
//
//  Created by Khoa Pham on 05/09/2022.
//

import Foundation
import RxSwift

public protocol UserRemoteAPI {

  func getUsers() -> Observable<UserResponse>
}

enum RemoteAPIError: Error {
  
  case unknown
  case createURL
  case httpError
}
