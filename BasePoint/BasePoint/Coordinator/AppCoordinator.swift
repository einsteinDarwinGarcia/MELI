//
//  AppCoordinator.swift
//  BasePoint
//
//  Created by Einstein Darwin Garcia Mendez on 11/05/21.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    typealias P = AppCoordinator
    
    private weak var window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start(_ navigationController: UINavigationController)  {
        let coordinator = RootMasterCoordinator<AppCoordinator>(window: window)
        coordinate(to: coordinator, navigationController)
    }
}
