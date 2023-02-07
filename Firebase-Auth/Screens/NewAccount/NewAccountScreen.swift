//
//  NewAccountScreen.swift
//  Firebase-Auth
//
//  Created by emre usul on 5.02.2023.
//

import UIKit

protocol NewAccountScreenInterface {
    func configureVC()
    func showLoginError(errorType: LoginError)
    func succesfullAccountPopUp()
}


final class NewAccountScreen: UIViewController {
    
    private let viewModel = NewAccountScreenViewModel()
    private var emailTextField: UITextField!
    private var passwordTextField: UITextField!
    private var emailLabel: UILabel!
    private var passwordLabel: UILabel!
    private var createButton: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.view = self
        viewModel.viewDidLoad()
    }
    
    @objc private func didTapCreateButton(sender: UIButton) {
        sender.animateButton()
        guard let email = emailTextField.text,
                let password = passwordTextField.text
        else { return }
        viewModel.createNewAccount(email: email, password: password)
        
    }
}

extension NewAccountScreen: NewAccountScreenInterface {
    func configureVC() {
        
        view.backgroundColor = UIColor.white
        
        emailTextField = UITextField()
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.borderColor = UIColor.black.cgColor
        emailTextField.layer.cornerRadius = 10
        emailTextField.layer.masksToBounds = true
        emailTextField.textColor = UIColor.systemBackground
        emailTextField.autocapitalizationType = .none
        emailTextField.becomeFirstResponder()
        emailTextField.autocorrectionType = .no
        view.addSubview(emailTextField)
        
        passwordTextField = UITextField()
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = UIColor.black.cgColor
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.layer.masksToBounds = true
        passwordTextField.textColor = UIColor.systemBackground
        passwordTextField.autocapitalizationType = .none
        view.addSubview(passwordTextField)
        
        emailLabel = UILabel()
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.text = "Email"
        emailLabel.font = .boldSystemFont(ofSize: 17)
        emailLabel.textColor = .black
        view.addSubview(emailLabel)
        
        
        passwordLabel = UILabel()
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.text = "Password"
        passwordLabel.textColor = .black
        passwordLabel.font = .boldSystemFont(ofSize: 17)
        view.addSubview(passwordLabel)
        
        createButton = UIButton()
        createButton.translatesAutoresizingMaskIntoConstraints = false
        createButton.setTitle("Sign Up", for: .normal)
        createButton.setTitleColor(.white, for: .normal)
        
        createButton.addTarget(self, action: #selector(didTapCreateButton), for: .touchUpInside)
        
        createButton.backgroundColor = UIColor.systemGreen
        createButton.layer.cornerRadius = 10
        view.addSubview(createButton)
        
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 300),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            emailTextField.heightAnchor.constraint(equalToConstant: 45),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor,constant: 40),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            passwordTextField.heightAnchor.constraint(equalToConstant: 45),
            
            emailLabel.bottomAnchor.constraint(equalTo: emailTextField.topAnchor, constant: -5),
            emailLabel.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor,constant: 5),
            emailLabel.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            
            passwordLabel.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: -5),
            passwordLabel.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor, constant: 5),
            passwordLabel.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            
            createButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 35),
            createButton.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            createButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            createButton.heightAnchor.constraint(equalToConstant: 45),
            
        ])
        
    }
    
    func showLoginError(errorType: LoginError) {
        
        switch errorType {
        case .emptyEmail:
            let alert = UIAlertController(title: "Email cannot be blank!", message: "",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Try again", style: .destructive))
            present(alert, animated: true)
        case .emptyPassword:
            let alert = UIAlertController(title: "Password cannot be blank!", message: "",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Try again", style: .destructive))
            present(alert, animated: true)
        case .wrong:
            break;
        case .atLeastSix:
            let alert = UIAlertController(title: "Password must be at least 6 digit!", message: "",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Try again", style: .destructive))
            present(alert, animated: true)
        }
    }
    
    func succesfullAccountPopUp() {
        let alert = UIAlertController(title: "New Account Successfully Created!", message: "",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okey", style: .default, handler: { _ in
            let navigateVC = AuthorizationScreen()
            navigateVC.modalPresentationStyle = .fullScreen
            navigateVC.modalTransitionStyle = .flipHorizontal
            self.present(navigateVC, animated: true)
        }))
        present(alert, animated: true)
    }
}
