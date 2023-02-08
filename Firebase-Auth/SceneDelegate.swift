//
//  SceneDelegate.swift
//  Firebase-Auth
//
//  Created by emre usul on 5.02.2023.
//

import UIKit
import Firebase


class SceneDelegate: UIResponder, UIWindowSceneDelegate {


    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        FirebaseApp.configure()
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
     //   window?.rootViewController = UINavigationController(rootViewController: AuthorizationScreen())
        window?.rootViewController = AuthorizationScreen()
        window?.makeKeyAndVisible()
    }
}

