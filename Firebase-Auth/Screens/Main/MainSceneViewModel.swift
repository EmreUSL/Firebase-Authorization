//
//  MainSceneViewModel.swift
//  Firebase-Auth
//
//  Created by emre usul on 7.02.2023.
//

import Foundation


protocol MainSceneViewModelInterface {
    var view: MainSceneInterface? { get set}
    func viewDidLoad()
}


final class MainSceneViewModel {
    var view: MainSceneInterface?
}

extension MainSceneViewModel: MainSceneViewModelInterface {
    func viewDidLoad() {
        view?.configureVC()
    }
}
