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
    
    var viewModel: MainViewModel!
    
    @IBOutlet weak var kolodaView: KolodaView!
    
    var images = [UIImage]()
    var cardControllers = [CardViewController]()
    let userRepository = GojekUserRepository(remoteAPI: GojekCloudUserRemoteAPI())
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = MainViewModel(userRepository: userRepository)
        
        userRepository.getUsers().subscribe(onNext: { userResponse in
            print(userResponse)
        }).disposed(by: disposeBag)
                
        kolodaView.dataSource = self
        kolodaView.delegate = self
        
        bindUI()
    }
    
    func loadCardControllers() {
        let users = viewModel.people.value ?? []
        users.forEach { user in
            let controller = storyboard?.instantiateViewController(identifier: "CardViewController") as! CardViewController
            addChild(controller)
            cardControllers.append(controller)
        }
    }
    
    func bindUI() {
      viewModel.people.asDriver()
            .drive(onNext: { [weak self] _ in
                self?.loadCardControllers()
                self?.kolodaView.reloadData()
            })
        .disposed(by: disposeBag)
    }

}

extension MainViewController: KolodaViewDelegate {
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        koloda.reloadData()
    }
}

extension MainViewController: KolodaViewDataSource {

    func kolodaNumberOfCards(_ koloda:KolodaView) -> Int {
        return viewModel.people.value?.count ?? 0
    }

    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        let controller = cardControllers[index]
        controller.update(with: viewModel.people.value?[index] ?? nil)
        return controller.view
    }
}
