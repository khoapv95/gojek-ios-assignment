//
//  CardViewController.swift
//  GojekAssignment
//
//  Created by Khoa Pham on 04/09/2022.
//

import UIKit

class CardViewController: UIViewController {
    
    @IBOutlet weak var avatar: UIImageView!
    var image: UIImage! {
        didSet {
            DispatchQueue.main.async {
                self.avatar.image = self.image
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        avatar.layer.cornerRadius = 80
        avatar.contentMode = .scaleAspectFill
        avatar.clipsToBounds = true
    }

}
