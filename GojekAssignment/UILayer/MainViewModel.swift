//
//  MainViewModel.swift
//  GojekAssignment
//
//  Created by Khoa Pham on 06/09/2022.
//

import Foundation
import RxSwift
import RxCocoa
import Reachability

public class MainViewModel {
    
    private let disposeBag = DisposeBag()

    // MARK: - Properties
    let userRepository: UserRepository
    let reachability: Reachability

    // MARK: - Output
    let people = BehaviorRelay<[PersonResponse]?>(value: nil)
    
    // MARK: - Methods
    public init(userRepository: UserRepository) {
        self.userRepository = userRepository
        self.reachability = try! Reachability()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)),
                                               name: .reachabilityChanged, object: reachability)
        do {
            try reachability.startNotifier()
        } catch {
            print("could not start reachability notifier")
        }
    }
    
    @objc func reachabilityChanged(note: Notification) {
        
        let reachability = note.object as! Reachability
        
        switch reachability.connection {
        case .wifi, .cellular:
            print("Reachable via WiFi")
            Observable.zip(userRepository.getUsers(), userRepository.getUsersOnDisk()).subscribe(onNext: { [weak self] (remoteUsers, localUsers) in
                guard let strongSelf = self else { return }
                for remoteUser in remoteUsers {
                    for localUser in localUsers {
                        remoteUser.isFavorite = remoteUser.mobileNumber! == localUser.mobileNumber!
                    }
                }
                strongSelf.people.accept(remoteUsers)
            }).disposed(by: disposeBag)
        case .unavailable:
            print("Network not reachable")
            userRepository.getUsersOnDisk().bind(to: people).disposed(by: disposeBag)
        case .none:
            print("None")
        }
    }
}
