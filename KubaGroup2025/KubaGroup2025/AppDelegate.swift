//
//  AppDelegate.swift
//  KubaGroup2025
//
//  Created by Ulrik Skov-Lorentzen on 30/06/2025.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    // MARK: - Public Properties

    var appCoordinator: AppCoordinator?
    let iTunesMusicService = ITunesMusicService()

    // MARK: - Computed Properties

    static var shared: AppDelegate = {
        let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate

        guard let shared = appDelegate else {
            fatalError("Failed to create shared instance of AppDelegate.")
        }

        return shared
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

