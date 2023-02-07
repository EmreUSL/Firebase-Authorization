//
//  MainScene.swift
//  Firebase-Auth
//
//  Created by emre usul on 7.02.2023.
//

import UIKit

protocol MainSceneInterface {
    func configureVC()
}

final class MainScene: UIViewController {

    private let viewModel = MainSceneViewModel()
    private var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.view = self
        viewModel.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}

extension MainScene: MainSceneInterface {
    func configureVC() {
        
        view.backgroundColor = UIColor.white
        
        button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("LogOut", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.systemGreen
        
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 250),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
