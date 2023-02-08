//
//  MainSceneViewModel.swift
//  Firebase-Auth
//
//  Created by emre usul on 7.02.2023.
//

import Foundation
import Firebase


protocol MainSceneViewModelInterface {
    var view: MainSceneInterface? { get set}
    func viewDidLoad()
    func logOut()
}


final class MainSceneViewModel {
    var view: MainSceneInterface?
}

extension MainSceneViewModel: MainSceneViewModelInterface {
    
    func viewDidLoad() {
        view?.configureVC()
    }
    
    func logOut() {
        
        if Firebase.Auth.auth().currentUser != nil {
            do {
                try Firebase.Auth.auth().signOut()
                view?.navigateLogOut()
            } catch {
                print("An error occured")
            }
        }
    }
}
