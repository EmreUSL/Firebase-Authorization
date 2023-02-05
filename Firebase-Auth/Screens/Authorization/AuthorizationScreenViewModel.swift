//
//  AuthorizationScreenViewModel.swift
//  Firebase-Auth
//
//  Created by emre usul on 5.02.2023.
//

import Foundation


protocol AuthorizationScreenViewModelInterface {
    var view: AuthorizationScreenInterface? { get set }
    func viewDidLoad()
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
}
