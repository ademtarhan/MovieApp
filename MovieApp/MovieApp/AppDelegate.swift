//
//  AppDelegate.swift
//  MovieApp
//
//  Created by Adem Tarhan on 16.08.2022.
//

import UIKit
import FirebaseCore
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    var rootViewController: UIViewController? {
        get { window?.rootViewController }
        set {
            window?.rootViewController = newValue
            window?.makeKeyAndVisible()
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        initWindow()
        initRoot()

        return true
    }

    /// - Initializing window
    private func initWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
    }

    /// - Initializing root
    private func initRoot() {
        let home = HomeRouter.shared.home
        let login = LogInRouter.shared.logIn
        let root = UINavigationController(rootViewController: home as! UIViewController)
        rootViewController = root
    }
}
