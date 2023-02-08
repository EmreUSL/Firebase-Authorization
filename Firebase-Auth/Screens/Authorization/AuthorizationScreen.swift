//
//  ViewController.swift
//  Firebase-Auth
//
//  Created by emre usul on 5.02.2023.
//

import UIKit

protocol AuthorizationScreenInterface: AnyObject {
    func configureTextFields()
    func configureLabels()
    func configureButtons()
    func showLoginError(errorType: LoginError)
    func navigateMainMenu()
}

class AuthorizationScreen: UIViewController {

    private var viewModel = AuthorizationScreenViewModel()
    private var userTextField: UITextField!
    private var passwordTextField: UITextField!
    private var emailLabel: UILabel!
    private var passwordLabel: UILabel!
    private var informationLabel: UILabel!
    private var loginButton: UIButton!
    private var showPasswordButton: UIButton!
    private var imageView: UIImageView!


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

    @objc private func didTapNewAccountButton(_ sender: UITapGestureRecognizer) {
        let navigateVC = NewAccountScreen()
        navigateVC.modalPresentationStyle = .fullScreen
        self.present(navigateVC, animated: true)
    }
    
    @objc private func didTapShowPasswordButton(sender: UIButton) {
        let result = viewModel.getShowPasswordImageName()
        let image = result.0
        let check = result.1
        showPasswordButton.setImage(UIImage(systemName: image), for: .normal)
        passwordTextField.isSecureTextEntry = check
    }
}

extension AuthorizationScreen: AuthorizationScreenInterface {
 
    //MARK: - TextFields
  
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
        userTextField.autocorrectionType = .no
        userTextField.leftViewMode = .always
        userTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
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
        passwordTextField.leftViewMode = .always
        passwordTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        passwordTextField.becomeFirstResponder()
        view.addSubview(passwordTextField)
    
        imageView = UIImageView()
        imageView.image = UIImage(named: "black")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        
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
            
            imageView.topAnchor.constraint(equalTo: view.topAnchor,constant: 50),
            imageView.bottomAnchor.constraint(equalTo: userTextField.topAnchor, constant: -30),
            imageView.trailingAnchor.constraint(equalTo: userTextField.trailingAnchor),
            imageView.leadingAnchor.constraint(equalTo: userTextField.leadingAnchor)
        
        ])
    }
    
    //MARK: - Labels
    
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
        let attributedString = NSMutableAttributedString.init(string: "Don't have an account?")
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range:
                                        NSRange.init(location: 0, length: attributedString.length));
        informationLabel.attributedText = attributedString
        informationLabel.font = .boldSystemFont(ofSize: 19)
        informationLabel.textColor = .black
        informationLabel.textAlignment = .center
        
        let labelTap = UITapGestureRecognizer(target: self,
                                              action: #selector(didTapNewAccountButton(_:)))
        informationLabel.isUserInteractionEnabled = true
        informationLabel.addGestureRecognizer(labelTap)
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
    
    //MARK: - Button
    
    func configureButtons() {
        loginButton = UIButton()
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        
        loginButton.backgroundColor = UIColor.systemGreen
        loginButton.layer.cornerRadius = 10
        
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        view.addSubview(loginButton)
        
        
        showPasswordButton = UIButton()
        showPasswordButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        showPasswordButton.frame = CGRect(x: 300,
                                          y: 387,
                                          width: 50, height: 50)
        showPasswordButton.addTarget(self, action: #selector(didTapShowPasswordButton), for: .touchUpInside)
        showPasswordButton.tintColor = .black
        view.addSubview(showPasswordButton)
        
        
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 35),
            loginButton.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 45),
            
            informationLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80),
            informationLabel.leadingAnchor.constraint(equalTo: loginButton.leadingAnchor),
            informationLabel.trailingAnchor.constraint(equalTo: loginButton.trailingAnchor),
            
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
        case .atLeastSix:
            break;
        case .unaccepted:
            let alert = UIAlertController(title: "Unaccepted email type!", message: "",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Try again", style: .destructive))
            present(alert, animated: true)
        }
       
    }
    
    func navigateMainMenu() {
        let navigateVC = MainScene()
        navigateVC.modalPresentationStyle = .fullScreen
        self.present(navigateVC, animated: false)
    }
    
}
