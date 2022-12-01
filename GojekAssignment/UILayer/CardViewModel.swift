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
    
    var user: PersonResponse!
    
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
                text = "\(strongSelf.user.title ?? "") \(strongSelf.user.first ?? "") \(strongSelf.user.last ?? "")"
                constant = 0 * widthOfPerButton
            case .dob:
                text = strongSelf.user.dob ?? ""
                constant = 1 * widthOfPerButton
            case .location:
                text = strongSelf.user.country ?? ""
                constant = 2 * widthOfPerButton
            case .mobileNumber:
                text = strongSelf.user.mobileNumber ?? ""
                constant = 3 * widthOfPerButton
            }
            
            self?.outputSubject.onNext((text, constant, tag))
        })
        .disposed(by: disposeBag)
    }
    
}
