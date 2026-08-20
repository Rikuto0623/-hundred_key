//
//  SceneDelegate.swift
//  HundredKey
//
//  Created by 鈴木久美 on 2026/08/13.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions:
        UIScene.ConnectionOptions
    ) {

        guard
            let windowScene = scene as? UIWindowScene
        else {
            return
        }

        let window = UIWindow(
            windowScene: windowScene
        )

        let nameView =
            NameViewController()

        let navigationController =
            UINavigationController(
                rootViewController: nameView
            )

        window.rootViewController =
            navigationController

        self.window = window

        window.makeKeyAndVisible()
    }
}
