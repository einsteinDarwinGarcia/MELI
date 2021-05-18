//
//  HomeViewCoordinator.swift
//  BasePoint
//
//  Created by Einstein Darwin Garcia Mendez on 11/05/21.
//

import UIKit

protocol HomeCoordinator: Coordinator { }

extension HomeCoordinator {
    
    func presentDetailView(name: String, navigationController: UINavigationController) {
        let coordinator = DetailViewCoordinator<Self>(userLogged: name)
        coordinate(to: coordinator, navigationController)
    }
    
}

final class HomeViewCoordinator<P: Coordinator>: HomeCoordinator {
    
    private var networking: HTTPManager
    private var usesCase: ValidateAuthorizationUsesCase
    
    init( _ networking: HTTPManager = HTTPManager()) {
        self.networking = networking
        self.usesCase = ImplementeValidateAuthorizationUsesCase(networkingLayer: self.networking)
    }
    
    func start(_ navigationController: UINavigationController) {
        let vc = HomeViewFactory.make(with: self, usesCase: usesCase)
        navigationController.pushViewController(vc, animated: true)
    }
    
    deinit {
        print("\(identifier) deinit HomeViewCoordinator")
    }
}

// MARK: Factory

enum HomeViewFactory {
    static func make<C: HomeCoordinator>(with coordinator: C, usesCase: ValidateAuthorizationUsesCase) -> HomeViewController {
        let viewModel =  HomeViewModel(coordinator: coordinator, usesCase: usesCase)
        let vc = HomeViewController.create(with: viewModel)
        return vc
    }
}
