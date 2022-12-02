//
//  GojekAppDependencyContainer.swift
//  GojekAssignment
//
//  Created by Icebreaker on 02/12/2022.
//

import UIKit

class GojekAppDependencyContainer {
    
    // Long-lived dependencies
    let sharedUserRepository: UserRepository
    
    // MARK: - Methods
    init() {
        func makeUserRepository() -> UserRepository {
          let dataStore = makeUserDataStore()
          let remoteAPI = makeUserRemoteAPI()
          return GojekUserRepository(remoteAPI: remoteAPI, datastore: dataStore)
        }
        
        func makeUserDataStore() -> UserDataStore {
            return UserDataStoreInDisk()
        }
        
        func makeUserRemoteAPI() -> UserRemoteAPI {
            return GojekCloudUserRemoteAPI()
        }
        
        self.sharedUserRepository = makeUserRepository()
    }
    
    func makeMainViewModel() -> MainViewModel {
      return MainViewModel(userRepository: sharedUserRepository)
    }
    
    func makeMainViewController() -> MainViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainVC = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        mainVC.viewModel = makeMainViewModel()
        return mainVC
    }
}
