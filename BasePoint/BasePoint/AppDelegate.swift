//
//  AppDelegate.swift
//  BasePoint
//
//  Created by Einstein Darwin Garcia Mendez on 10/05/21.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var coordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let rootNavigationController = UINavigationController()
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        let coordinator = AppCoordinator(window: window)
    
        coordinator.start(rootNavigationController)
        self.coordinator = coordinator
        
        return true
    }


}

