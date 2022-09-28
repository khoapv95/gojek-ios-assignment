//
//  CardViewController.swift
//  GojekAssignment
//
//  Created by Khoa Pham on 04/09/2022.
//

import UIKit
import RxSwift
import RxCocoa

class CardViewController: UIViewController {
    
    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var horizontalLineView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet weak var dobButton: UIButton!
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var mobileNumberButton: UIButton!
    
    @IBOutlet weak var horizontalLineLeadingConstraint: NSLayoutConstraint!
    
    let disposeBag = DisposeBag()
    
    let viewModel = CardViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        roundedView.layer.cornerRadius = 84
        roundedView.layer.borderWidth = 2
        roundedView.layer.borderColor = UIColor.lightGray.cgColor
        
        photo.layer.cornerRadius = 80
        photo.contentMode = .scaleAspectFill
        photo.clipsToBounds = true
        
        let mint = UIColor(red: 148/255, green: 201/255, blue: 115/255, alpha: 1)
        photoButton.setImage(tintedImage("user", withTintColor: mint), for: .normal)
        photoButton.tag = 0
        dobButton.setImage(tintedImage("calendar", withTintColor: .lightGray), for: .normal)
        dobButton.tag = 1
        locationButton.setImage(tintedImage("locator", withTintColor: .lightGray), for: .normal)
        locationButton.tag = 2
        mobileNumberButton.setImage(tintedImage("call", withTintColor: .lightGray), for: .normal)
        mobileNumberButton.tag = 3
        
        bindUI()
    }
    
    func bindUI() {
        viewModel.outputSubject.asDriver(onErrorJustReturn: 0)
            .drive(onNext: { [weak self] constant in
                self?.horizontalLineLeadingConstraint.constant = constant
                UIView.animate(withDuration: 0.2) {
                    self?.view.layoutIfNeeded()
                }
            })
        .disposed(by: disposeBag)
    }
    
    func update(with user: User?) {
        guard let user = user else {
            return
        }
        DispatchQueue.main.async {
            self.photo.setImage(with: URL(string: user.photo.large))
            self.nameLabel.text = "\(user.name.title) \(user.name.first) \(user.name.last)"
        }
    }
    
    private func tintedImage(_ named: String, withTintColor color: UIColor) -> UIImage? {
        return UIImage(named: named)?.withTintColor(color, renderingMode: .alwaysOriginal)
    }

    @IBAction func didTapButton(_ sender: UIButton) {
        let widthOfPerButton = view.frame.width / 4
        viewModel.inputSubject.onNext((sender.tag, widthOfPerButton))
    }
}
