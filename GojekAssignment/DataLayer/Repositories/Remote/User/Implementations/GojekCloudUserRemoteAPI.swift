//
//  GojekCloudUserRemoteAPI.swift
//  GojekAssignment
//
//  Created by Khoa Pham on 05/09/2022.
//

import Foundation
import RxSwift
import RxCocoa

public class GojekCloudUserRemoteAPI: UserRemoteAPI {
    
    // MARK: - Properties
    let domain = "randomuser.me"
    
    public func getUsers() -> Observable<UserResponse> {
        return Observable.just(URL(string: "https://\(domain)/api/?results=50")!)
            .flatMap { url -> Observable<(response: HTTPURLResponse, data: Data)> in
                let request = URLRequest(url: url)
                return URLSession.shared.rx.response(request: request)
            }.map { response, data -> UserResponse in
                
                if 200..<300 ~= response.statusCode {
                    return try JSONDecoder().decode(UserResponse.self, from: data)
                } else {
                    throw RxCocoaURLError.httpRequestFailed(response: response, data: data)
                }
                
            }.asObservable()
    }
    
}
