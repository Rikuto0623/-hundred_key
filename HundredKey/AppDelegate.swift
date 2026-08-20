//
//  AppDelegate.swift
//  HundredKey
//
//  Created by 鈴木久美 on 2026/08/13.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions:
        [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {

        return true
    }

    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession:
        UISceneSession,
        options:
        UIScene.ConnectionOptions
    ) -> UISceneConfiguration {

        return UISceneConfiguration(
            name: "Default Configuration",
            sessionRole: connectingSceneSession.role
        )
    }
}
