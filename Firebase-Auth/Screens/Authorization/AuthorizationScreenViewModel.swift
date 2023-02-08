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
    case atLeastSix
    case unaccepted
}

protocol AuthorizationScreenViewModelInterface {
    var view: AuthorizationScreenInterface? { get set }
    func viewDidLoad()
    func loginAccount(email: String, password: String)
    func getShowPasswordImageName() -> (String,Bool)
    
}

final class AuthorizationScreenViewModel {
    weak var view: AuthorizationScreenInterface?
    private var check = true
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
       
        if email.contains("@gmail.com") != true {
            view?.showLoginError(errorType: LoginError.unaccepted)
        }
        
        Firebase.Auth.auth().signIn(withEmail: email, password: password) { _, error in
            guard error == nil else {
                self.view?.showLoginError(errorType: LoginError.wrong)
                return
            }
            self.view?.navigateMainMenu()
        }
    }
    
    func getShowPasswordImageName() -> (String,Bool) {
        check = !check
        
        if check == true {
            return ("eye.slash", check)
        } else {
           return ("eye", check)
        }
    }
    
   
}
