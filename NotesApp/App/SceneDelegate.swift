//
//  SceneDelegate.swift
//  NotesApp
//
//  Created by Luka Gujejiani on 31.10.24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
        let rootViewController = ListViewController(viewModel: ListViewModel())
        let navigationController = UINavigationController(rootViewController: rootViewController)
        
        window.rootViewController = navigationController
        self.window = window
        window.makeKeyAndVisible()
    }
}
