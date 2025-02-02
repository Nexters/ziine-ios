//
//  SceneDelegate.swift
//  ZiineApp
//
//  Created by Geon Woo lee on 1/25/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        window?.backgroundColor = .systemBackground
        
        let builder = AppRootBuilder()
        let routing = builder.build()

        window?.rootViewController = routing.viewController
        
        window?.makeKeyAndVisible()
    }
}

