//
//  HomeViewModel.swift
//  BasePoint
//
//  Created by Einstein Darwin Garcia Mendez on 11/05/21.
//

import Foundation
import UIKit

protocol HomeViewModelImplementation: Navigation {
    var messageAuthorized: Observable<String> { get set }
    var activateButton: Observable<Bool> { get set }
    func validateInput(text: String)
}

class HomeViewModel<C: HomeCoordinator>: BaseViewModel<C>, HomeViewModelImplementation {
    
    var usesCase: ValidateAuthorizationUsesCase
    
    var messageAuthorized = Observable<String>("")
    var activateButton = Observable<Bool>(false)
    
    var welcomeMessage = String()
    
    init(coordinator: C, usesCase: ValidateAuthorizationUsesCase) {
        self.usesCase = usesCase
        super.init(coordinator: coordinator)
    }
    
    func validateInput(text: String) {
        if !text.isEmpty {
            let request = ValidateAuthorizationUsesCaseRequestValue(query: text, page: 1)
            usesCase.execute(requestValue: request) { [weak self] (result) in
                switch result {
                case .success(let value):
                    if value.state == .authorized {
                        self?.messageAuthorized.value = "Usuario Autorizado"
                        self?.activateButton.value = true
                        self?.welcomeMessage = "Bienvenido a Point Clean Arquitecture"
                    } else {
                        self?.messageAuthorized.value = "NO Autorizado"
                        self?.activateButton.value = false
                    }
                case .failure(_):
                    break
                }
            }
        }
    }
    
}

// MARK: Navigation

extension HomeViewModel {
    func goToFlow(with navigation: UINavigationController) {
        coordinator?.presentDetailView(name: self.welcomeMessage, navigationController: navigation)
    }
}
