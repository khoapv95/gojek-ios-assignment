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
    let outputSubject = PublishSubject<CGFloat>()
    
    init() {
        bindInput()
    }
    
    private func bindInput() {
        inputSubject.subscribe(onNext: { [weak self] (tag, widthOfPerButton) in
            guard let type = CardButtonType(rawValue: tag) else {
                return
            }
            
            let constant: CGFloat
            
            switch type {
            case .photo:
                print("User tapped")
                constant = 0 * widthOfPerButton
            case .dob:
                print("DOB tapped")
                constant = 1 * widthOfPerButton
            case .location:
                print("Location tapped")
                constant = 2 * widthOfPerButton
            case .mobileNumber:
                print("Mobile number tapped")
                constant = 3 * widthOfPerButton
            }
            
            self?.outputSubject.onNext(constant)
        })
        .disposed(by: disposeBag)
    }
    
}
