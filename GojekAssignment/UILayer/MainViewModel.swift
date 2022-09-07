//
//  MainViewModel.swift
//  GojekAssignment
//
//  Created by Khoa Pham on 06/09/2022.
//

import Foundation
import RxSwift
import RxCocoa

public class MainViewModel {
    
    private let disposeBag = DisposeBag()

    // MARK: - Properties
    let userRepository: UserRepository
    
    // MARK: - Output
    let people = BehaviorRelay<[User]?>(value: nil)
    
    // MARK: - Methods
    public init(userRepository: UserRepository) {
      self.userRepository = userRepository
        bindOutput()
    }
    
    func bindOutput() {
        userRepository.getUsers().map { $0.results }.bind(to: people).disposed(by: disposeBag)
    }
}
