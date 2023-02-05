//
//  ViewController.swift
//  Firebase-Auth
//
//  Created by emre usul on 5.02.2023.
//

import UIKit

protocol AuthorizationScreenInterface {
    func configureTextFields()
    func configureLabels()
    func configureButtons()
    func showLoginError(errorType: LoginError)
}

class AuthorizationScreen: UIViewController {

    private var viewModel = AuthorizationScreenViewModel()
    private var userTextField: UITextField!
    private var passwordTextField: UITextField!
    private var emailLabel: UILabel!
    private var passwordLabel: UILabel!
    private var informationLabel: UILabel!
    private var loginButton: UIButton!
    private var newAccountButton: UIButton!

    override func viewDidAppear(_ animated: Bool) {
        userTextField.becomeFirstResponder() 
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
    
    @objc private func didTapLoginButton(sender: UIButton) {
        sender.animateButton()
        guard let email = userTextField.text,
        let password = passwordTextField.text
        else { return }
        viewModel.loginAccount(email: email, password: password)
    }

    @objc private func didTapNewAccountButton(sender: UIButton) {
        sender.animateButton()
        let newAccountScreen = NewAccountScreen()
        navigationController?.pushViewController(newAccountScreen, animated: true)
    }
    
}

extension AuthorizationScreen: AuthorizationScreenInterface {
  
    func configureTextFields() {
        view.backgroundColor = UIColor.white
        
        userTextField = UITextField()
        userTextField.translatesAutoresizingMaskIntoConstraints = false
        userTextField.layer.borderWidth = 1
        userTextField.layer.borderColor = UIColor.black.cgColor
        userTextField.layer.cornerRadius = 10
        userTextField.layer.masksToBounds = true
        userTextField.autocapitalizationType = .none
        userTextField.textColor = UIColor.systemBackground
        userTextField.becomeFirstResponder()
        view.addSubview(userTextField)

        passwordTextField = UITextField()
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = UIColor.black.cgColor
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.layer.masksToBounds = true
        passwordTextField.textColor = UIColor.systemBackground
        passwordTextField.isSecureTextEntry = true
        passwordTextField.autocapitalizationType = .none
        passwordTextField.becomeFirstResponder()
        view.addSubview(passwordTextField)
    
        NSLayoutConstraint.activate([
            userTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor,constant: -100),
            userTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            userTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            userTextField.heightAnchor.constraint(equalToConstant: 45),
            
            passwordTextField.topAnchor.constraint(equalTo: userTextField.bottomAnchor,constant: 40),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            passwordTextField.heightAnchor.constraint(equalToConstant: 45),
        
        ])
    }
    
    func configureLabels() {
        
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
        
        informationLabel = UILabel()
        informationLabel.translatesAutoresizingMaskIntoConstraints = false
        let attributedString = NSMutableAttributedString.init(string: "Don't you have an account?")
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range:
                                        NSRange.init(location: 0, length: attributedString.length));
        informationLabel.attributedText = attributedString
        informationLabel.font = .boldSystemFont(ofSize: 17)
        informationLabel.textColor = .black
        informationLabel.textAlignment = .center
        view.addSubview(informationLabel)
        
        
        
        NSLayoutConstraint.activate([
            emailLabel.bottomAnchor.constraint(equalTo: userTextField.topAnchor, constant: -5),
            emailLabel.leadingAnchor.constraint(equalTo: userTextField.leadingAnchor,constant: 5),
            emailLabel.trailingAnchor.constraint(equalTo: userTextField.trailingAnchor),
            
            passwordLabel.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: -5),
            passwordLabel.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor, constant: 5),
            passwordLabel.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            
        ])
    }
    
    func configureButtons() {
        loginButton = UIButton()
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        
        loginButton.backgroundColor = UIColor.systemGreen
        loginButton.layer.cornerRadius = 10
      
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        view.addSubview(loginButton)
        
        
        newAccountButton = UIButton()
        newAccountButton.translatesAutoresizingMaskIntoConstraints = false
        newAccountButton.setTitle("Create a New Account", for: .normal)
        newAccountButton.setTitleColor(.white, for: .normal)
        
        newAccountButton.backgroundColor = UIColor.systemGreen
        newAccountButton.layer.cornerRadius = 10
        
        newAccountButton.addTarget(self, action: #selector(didTapNewAccountButton), for: .touchUpInside)
        view.addSubview(newAccountButton)
        
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 35),
            loginButton.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 45),
            
            newAccountButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -90),
            newAccountButton.leadingAnchor.constraint(equalTo: loginButton.leadingAnchor),
            newAccountButton.trailingAnchor.constraint(equalTo: loginButton.trailingAnchor),
            newAccountButton.heightAnchor.constraint(equalToConstant: 40),
            
            informationLabel.bottomAnchor.constraint(equalTo: newAccountButton.topAnchor, constant: -5),
            informationLabel.leadingAnchor.constraint(equalTo: newAccountButton.leadingAnchor),
            informationLabel.trailingAnchor.constraint(equalTo: newAccountButton.trailingAnchor),
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
            let alert = UIAlertController(title: "Your email or password wrong!", message: "",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Try again", style: .destructive))
            present(alert, animated: true)
        }
       
    }
    
}
