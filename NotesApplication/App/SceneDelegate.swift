//
//  SceneDelegate.swift
//  NotesApplication
//
//  Created by Ana on 11/4/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        window.rootViewController = UINavigationController(rootViewController: NotesViewController())
        self.window = window
        self.window?.makeKeyAndVisible()
    }
}