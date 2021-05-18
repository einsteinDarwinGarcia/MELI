//
//  DetailViewCoordinator.swift
//  BasePoint
//
//  Created by Einstein Darwin Garcia Mendez on 17/05/21.
//

import UIKit

protocol DetailCoordinator: Coordinator {
    
}

final class DetailViewCoordinator<P: Coordinator>: DetailCoordinator {
    
    var userLogged: String
    
    init(userLogged: String) {
        self.userLogged = userLogged
    }
    
    func start(_ navigationController: UINavigationController) {
        let vc = DetailViewFactory.make(with: self, userLogged: self.userLogged)
        navigationController.pushViewController(vc, animated: true)
    }
    
    deinit {
        print("\(identifier) deinit DetailViewCoordinator")
    }
}

// MARK: Factory

enum DetailViewFactory {
    static func make<C: DetailCoordinator>(with coordinator: C, userLogged: String) -> DetailViewController {
        let viewModel = DetailViewModel(coordinator: coordinator, userLogged: userLogged)
        let vc = DetailViewController.create(with: viewModel)
        return vc
    }
}
