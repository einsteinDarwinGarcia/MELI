//
//  BaseViewModel.swift
//  BasePoint
//
//  Created by Einstein Darwin Garcia Mendez on 11/05/21.
//

import Foundation
import UIKit

protocol Navigation {
    func goToFlow(with navigation: UINavigationController)
}

class BaseViewModel<C: Coordinator> {
    
    private(set) weak var coordinator: C?
    
    init(coordinator: C) {
        self.coordinator = coordinator
    }
    
    deinit {
        coordinator?.stop()
    }
    
}
