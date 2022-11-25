//
//  CardViewModel.swift
//  GojekAssignment
//
//  Created by Khoa Pham on 11/09/2022.
//

import Foundation
import RxSwift
import RxCocoa

enum CardButtonType: Int {
    case photo
    case dob
    case location
    case mobileNumber
}

public class CardViewModel {
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Input
    let inputSubject = PublishSubject<(Int, CGFloat)>()
    
    // MARK: - Output
    let outputSubject = PublishSubject<(String, CGFloat, Int)>()
    
    var user: User!
    
    init() {
        bindInput()
    }
    
    private func bindInput() {
        inputSubject.subscribe(onNext: { [weak self] (tag, widthOfPerButton) in
            guard let strongSelf = self, let type = CardButtonType(rawValue: tag) else {
                return
            }
            
            let text: String
            let constant: CGFloat
            
            switch type {
            case .photo:
                print("User tapped")
                text = "\(strongSelf.user.name.title) \(strongSelf.user.name.first) \(strongSelf.user.name.last)"
                constant = 0 * widthOfPerButton
            case .dob:
                print("DOB tapped")
                text = strongSelf.user.dob.date
                constant = 1 * widthOfPerButton
            case .location:
                print("Location tapped")
                text = strongSelf.user.location.country
                constant = 2 * widthOfPerButton
            case .mobileNumber:
                print("Mobile number tapped")
                text = strongSelf.user.mobileNumber
                constant = 3 * widthOfPerButton
            }
            
            self?.outputSubject.onNext((text, constant, tag))
        })
        .disposed(by: disposeBag)
    }
    
}
