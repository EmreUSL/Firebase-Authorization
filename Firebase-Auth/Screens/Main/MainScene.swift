//
//  MainScene.swift
//  Firebase-Auth
//
//  Created by emre usul on 7.02.2023.
//

import UIKit

protocol MainSceneInterface {
    func configureVC()
    func navigateLogOut()
}

final class MainScene: UIViewController {

    private let viewModel = MainSceneViewModel()
    private var button: UIButton!
    private var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.view = self
        viewModel.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc private func didTapLogOutButton() {
        button.animateButton()
        viewModel.logOut()
    }
    
}

extension MainScene: MainSceneInterface {
   
    func configureVC() {
        
        view.backgroundColor = UIColor.white
        
        label = UILabel()
        label.text = "Welcome to the Main Screen"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 25)
        view.addSubview(label)
        
        button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("LogOut", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.systemGreen
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(didTapLogOutButton), for: .touchUpInside)
        
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            button.bottomAnchor.constraint(equalTo: label.topAnchor, constant: -20),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.heightAnchor.constraint(equalToConstant: 50),
            button.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func navigateLogOut() {
        let navigateVC = AuthorizationScreen()
        navigateVC.modalPresentationStyle = .fullScreen
        navigateVC.modalTransitionStyle = .partialCurl
        self.present(navigateVC, animated: true)
    }
    
}

