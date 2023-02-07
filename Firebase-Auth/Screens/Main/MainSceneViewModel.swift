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
        
        do {
            try Firebase.Auth.auth().signOut()
        } catch {
            print("An error occured")
        }
    }
    

}
