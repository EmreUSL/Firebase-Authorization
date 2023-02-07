//
//  NewAccountScreenViewModel.swift
//  Firebase-Auth
//
//  Created by emre usul on 5.02.2023.
//

import Foundation
import Firebase

protocol NewAccountScreenViewModelInterface {
    var view: NewAccountScreenInterface? { get set }
    func viewDidLoad()
    func createNewAccount(email: String, password: String)
}

final class NewAccountScreenViewModel {
    var view: NewAccountScreenInterface?
}

extension NewAccountScreenViewModel: NewAccountScreenViewModelInterface {
    func viewDidLoad() {
        view?.configureVC()
    }
    
    func createNewAccount(email: String, password: String) {
        
        if email == "" { view?.showLoginError(errorType: LoginError.emptyEmail); return }
        if password == "" { view?.showLoginError(errorType: LoginError.emptyPassword); return }
        
        
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { _, error in
            guard error == nil else {
                self.view?.showLoginError(errorType: LoginError.atLeastSix)
                return }
            self.view?.succesfullAccountPopUp()
        }
    }
}
