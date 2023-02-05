//
//  AuthorizationScreenViewModel.swift
//  Firebase-Auth
//
//  Created by emre usul on 5.02.2023.
//

import Foundation
import Firebase

enum LoginError {
    case emptyEmail
    case emptyPassword
    case wrong
}

protocol AuthorizationScreenViewModelInterface {
    var view: AuthorizationScreenInterface? { get set }
    func viewDidLoad()
    func loginAccount(email: String, password: String)
    
}

final class AuthorizationScreenViewModel {
    var view: AuthorizationScreenInterface?
}

extension AuthorizationScreenViewModel: AuthorizationScreenViewModelInterface {

    func viewDidLoad() {
        view?.configureTextFields()
        view?.configureLabels()
        view?.configureButtons()
    }
    
    func loginAccount(email: String, password: String) {
        
        if email == "" { view?.showLoginError(errorType: LoginError.emptyEmail); return }
        if password == "" { view?.showLoginError(errorType: LoginError.emptyPassword); return }
        
        Firebase.Auth.auth().signIn(withEmail: email, password: password) { _, error in
                guard error == nil else {
                    self.view?.showLoginError(errorType: LoginError.wrong)
                    return
                }
                
                //Navigate To MainMenu
            }
        
    }
   
}
