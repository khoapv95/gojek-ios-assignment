//
//  MainViewController.swift
//  GojekAssignment
//
//  Created by Khoa Pham on 04/09/2022.
//

import UIKit
import Koloda
import RxSwift

class MainViewController: UIViewController {
    
    @IBOutlet weak var kolodaView: KolodaView!
    
    var images = [UIImage]()
    var cardControllers = [CardViewController]()
    let userRepository = GojekUserRepository(remoteAPI: GojekCloudUserRemoteAPI())
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        userRepository.getUsers().subscribe(onNext: { userResponse in
            print(userResponse)
        }).disposed(by: disposeBag)
        
        images.append(UIImage(named: "avatar")!)
        images.append(UIImage(named: "avatar2")!)
        images.append(UIImage(named: "avatar3")!)
        
        loadCardControllers()
                
        kolodaView.dataSource = self
        kolodaView.delegate = self
    }
    
    func loadCardControllers() {
        images.forEach { _ in
            let controller = storyboard?.instantiateViewController(identifier: "CardViewController") as! CardViewController
            addChild(controller)
            cardControllers.append(controller)
        }
    }

}

extension MainViewController: KolodaViewDelegate {
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        koloda.reloadData()
    }
}

extension MainViewController: KolodaViewDataSource {

    func kolodaNumberOfCards(_ koloda:KolodaView) -> Int {
        return images.count
    }

    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        let controller = cardControllers[index]
        controller.image = images[index]
        return controller.view
    }
}
