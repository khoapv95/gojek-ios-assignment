//
//  CardViewController.swift
//  GojekAssignment
//
//  Created by Khoa Pham on 04/09/2022.
//

import UIKit

class CardViewController: UIViewController {
    
    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        roundedView.layer.cornerRadius = 84
        roundedView.layer.borderWidth = 2
        roundedView.layer.borderColor = UIColor.lightGray.cgColor
        
        photo.layer.cornerRadius = 80
        photo.contentMode = .scaleAspectFill
        photo.clipsToBounds = true
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

}
