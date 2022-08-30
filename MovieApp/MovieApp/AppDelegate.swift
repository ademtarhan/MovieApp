//
//  AppDelegate.swift
//  MovieApp
//
//  Created by Adem Tarhan on 16.08.2022.
//

import CoreData
import FirebaseCore
import UIKit
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
        let root = UINavigationController(rootViewController: login as! UIViewController)
        rootViewController = root
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MovieModel")
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
       
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
