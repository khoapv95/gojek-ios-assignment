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
    
    public func getUsers() -> Observable<[PersonResponse]> {
        return Observable.just(URL(string: "https://\(domain)/api/?results=50")!)
            .flatMap { url -> Observable<(response: HTTPURLResponse, data: Data)> in
                let request = URLRequest(url: url)
                return URLSession.shared.rx.response(request: request)
            }.map { response, data -> [PersonResponse] in
                
                if 200..<300 ~= response.statusCode {
                    let userResponse = try JSONDecoder().decode(UserResponse.self, from: data)
                    var results = [PersonResponse]()
                    for user in userResponse.results {
                        var person = PersonResponse()
                        person.title = user.name.title
                        person.first = user.name.first
                        person.last = user.name.last
                        person.dob = user.dob.date
                        person.country = user.location.country
                        person.mobileNumber = user.mobileNumber
                        person.photoURLString = user.photo.large
                        results.append(person)
                    }
                    return results
                } else {
                    throw RxCocoaURLError.httpRequestFailed(response: response, data: data)
                }
                
            }.asObservable()
    }
    
}
