//
//  DetailViewModel.swift
//  BasePoint
//
//  Created by Einstein Darwin Garcia Mendez on 17/05/21.
//

import Foundation

protocol DetailVviewModelImplementation {
    var userLogged: Observable<String> { get set }
}

final class DetailViewModel<C: DetailCoordinator>: BaseViewModel<C>, DetailVviewModelImplementation {
    var userLogged = Observable<String>("")
    
    init(coordinator: C, userLogged: String) {
        self.userLogged.value = userLogged
        super.init(coordinator: coordinator)
    }
    
}
