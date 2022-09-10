//
//  SceneDelegate.swift
//  Timer Work\Relax
//
//  Created by Александра  Севостьянова on 10.09.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScence = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScence)
        window.rootViewController = ViewController()
        window.makeKeyAndVisible()
        self.window = window
    }
}
