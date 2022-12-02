//
//  GojekAssignmentTests.swift
//  GojekAssignmentTests
//
//  Created by Icebreaker on 01/12/2022.
//

import XCTest
import RxSwift
@testable import GojekAssignment

final class GojekAssignmentTests: XCTestCase {
    
    let disposeBag = DisposeBag()
    
    let person = PersonResponse()

    override func setUp() {
        person.title = "Mr"
        person.first = "James"
        person.last = "Bond"
        person.dob = "09/03/1995"
        person.country = "England"
        person.mobileNumber = "0123456789"
    }

    func testPhotoSection() {
        let viewModel = CardViewModel()
        viewModel.user = person
        
        var result = ""
        var section = 0

        viewModel.outputSubject.asDriver(onErrorJustReturn: ("", 0, 0))
            .drive(onNext: { (text, constant, tag) in
                result = text
                section = tag
            })
        .disposed(by: disposeBag)
        
        viewModel.inputSubject.onNext((0, 0))
        
        XCTAssertEqual(result, "Mr James Bond")
        XCTAssertEqual(section, CardButtonType.photo.rawValue)
    }
    
    func testDOBSection() {
        let viewModel = CardViewModel()
        viewModel.user = person
        
        var result = ""
        var section = 0
        
        viewModel.outputSubject.asDriver(onErrorJustReturn: ("", 0, 0))
            .drive(onNext: { (text, constant, tag) in
                result = text
                section = tag
            })
        .disposed(by: disposeBag)
        
        viewModel.inputSubject.onNext((1, 0))
        
        XCTAssertEqual(result, "09/03/1995")
        XCTAssertEqual(section, CardButtonType.dob.rawValue)
    }
    
    func testLocationSection() {
        let viewModel = CardViewModel()
        viewModel.user = person
        
        var result = ""
        var section = 0
        
        viewModel.outputSubject.asDriver(onErrorJustReturn: ("", 0, 0))
            .drive(onNext: { (text, constant, tag) in
                result = text
                section = tag
            })
        .disposed(by: disposeBag)
        
        viewModel.inputSubject.onNext((2, 0))
        
        XCTAssertEqual(result, "England")
        XCTAssertEqual(section, CardButtonType.location.rawValue)
    }
    
    func testMobileNumberSection() {
        let viewModel = CardViewModel()
        viewModel.user = person
        
        var result = ""
        var section = 0
        
        viewModel.outputSubject.asDriver(onErrorJustReturn: ("", 0, 0))
            .drive(onNext: { (text, constant, tag) in
                result = text
                section = tag
            })
        .disposed(by: disposeBag)
        
        viewModel.inputSubject.onNext((3, 0))
        
        XCTAssertEqual(result, "0123456789")
        XCTAssertEqual(section, CardButtonType.mobileNumber.rawValue)
    }

}
