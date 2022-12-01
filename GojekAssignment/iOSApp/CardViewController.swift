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
    @IBOutlet weak var stackView: UIStackView!

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
        photoButton.setImage(UIImage(named: "user")?.withRenderingMode(.alwaysTemplate), for: .normal)
        photoButton.tintColor = mint
        photoButton.tag = 0
        dobButton.setImage(UIImage(named: "calendar")?.withRenderingMode(.alwaysTemplate), for: .normal)
        dobButton.tintColor = .lightGray
        dobButton.tag = 1
        locationButton.setImage(UIImage(named: "locator")?.withRenderingMode(.alwaysTemplate), for: .normal)
        locationButton.tintColor = .lightGray
        locationButton.tag = 2
        mobileNumberButton.setImage(UIImage(named: "call")?.withRenderingMode(.alwaysTemplate), for: .normal)
        mobileNumberButton.tintColor = .lightGray
        mobileNumberButton.tag = 3
        
        bindUI()
    }
    
    func bindUI() {
        viewModel.outputSubject.asDriver(onErrorJustReturn: ("", 0, 0))
            .drive(onNext: { [weak self] (text, constant, tag) in
                guard let strongSelf = self else { return }
                strongSelf.nameLabel.text = text
                strongSelf.horizontalLineLeadingConstraint.constant = constant
                for subview in strongSelf.stackView.arrangedSubviews {
                    guard let button = subview as? UIButton else { return }
                    if button.tag == tag {
                        let mint = UIColor(red: 148/255, green: 201/255, blue: 115/255, alpha: 1)
                        button.tintColor = mint
                    } else {
                        button.tintColor = .lightGray
                    }
                }
                UIView.animate(withDuration: 0.2) {
                    strongSelf.view.layoutIfNeeded()
                }
            })
        .disposed(by: disposeBag)
    }
    
    func update(with user: PersonResponse) {
        viewModel.user = user
        DispatchQueue.main.async {
            if let imageData = user.photoData {
                self.photo.image = UIImage(data: imageData)
            } else {
                self.photo.setImage(with: URL(string: user.photoURLString ?? ""))
            }
            self.nameLabel.text = "\(user.title ?? "") \(user.first ?? "") \(user.last ?? "")"
        }
    }
    
    private func tintedImage(_ named: String, withTintColor color: UIColor) -> UIImage? {
        return UIImage(named: named)?.withRenderingMode(.alwaysTemplate)
    }

    @IBAction func didTapButton(_ sender: UIButton) {
        let widthOfPerButton = view.frame.width / 4
        viewModel.inputSubject.onNext((sender.tag, widthOfPerButton))
    }
}
