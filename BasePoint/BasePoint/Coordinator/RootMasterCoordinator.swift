//
//  RootMasterCoordinator.swift
//  BasePoint
//
//  Created by Einstein Darwin Garcia Mendez on 11/05/21.
//

import Foundation
import UIKit

protocol RootViewCoordinator: Coordinator {
    
}

final class RootMasterCoordinator<P: Coordinator>: RootViewCoordinator {
    
    private weak var window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start(_ navigationController: UINavigationController) {
        
        let coordinator = HomeViewCoordinator<RootMasterCoordinator>()
        coordinate(to: coordinator, navigationController)
        
        self.window?.rootViewController = navigationController
        
    }
}


