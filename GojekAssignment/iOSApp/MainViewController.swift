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
    
    // MARK: - Properties
    var viewModel: MainViewModel!
    var images = [UIImage]()
    var cardControllers = [CardViewController]()
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var kolodaView: KolodaView!
    @IBOutlet weak var favoriteImgv: UIImageView!

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
                        
        kolodaView.dataSource = self
        kolodaView.delegate = self
        
        bindUI()
        favoriteImgv.isHidden = true
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
        guard !cardControllers.isEmpty, let person = viewModel.people.value?[index] else { return UIView() }
        let controller = cardControllers[index]
        favoriteImgv.isHidden = !person.isFavorite
        controller.update(with: person)
        return controller.view
    }
    
    func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection) {
        guard direction == .right, let user = viewModel.people.value?[index] else { return }
        let controller = cardControllers[index]
        user.photoData = controller.photo.image?.pngData()
        viewModel.userRepository.saveUserToDisk(user)
    }
}
