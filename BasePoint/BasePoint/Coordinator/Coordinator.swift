//
//  Coordinator.swift
//  BasePoint
//
//  Created by Einstein Darwin Garcia Mendez on 11/05/21.
//

import Foundation
import UIKit


protocol Coordinator: AssociatedObjects { // notice AssociatedObject conformance
    associatedtype P: Coordinator
    func start(_ navigationController: UINavigationController)
    func stop()
}

extension Coordinator {
    private(set) var identifier: UUID {
        get {
            guard let identifier: UUID = associatedObject(for: &identifierKey) else {
                self.identifier = UUID()
                return self.identifier
            }
            return identifier
        }
        set { setAssociatedObject(newValue, for: &identifierKey) }
    }
    
    private(set) var children: [UUID: Any] {
        get {
            guard let children: [UUID: Any] = associatedObject(for: &childrenKey) else {
                self.children = [UUID: Any]()
                return self.children
            }
            return children
        }
        set { setAssociatedObject(newValue, for: &childrenKey) }
    }
    
    // parent must be `weak` so we don't create a retain cycle
    private(set) weak var parent: P? {
        get { associatedObject(for: &parentKey) }
        set { setAssociatedObject(newValue, for: &parentKey, policy: .weak) }
    }
    

    
    private func store<T: Coordinator>(child coordinator: T) {
        children[coordinator.identifier] = coordinator
    }
    
    private func free<T: Coordinator>(child coordinator: T) {
        children.removeValue(forKey: coordinator.identifier)
    }
    
    func stop() {
        children.removeAll()
//        navigationController.viewControllers.removeAll()
        parent?.free(child: self)
    }
}
    
extension Coordinator {
    func coordinate<T: Coordinator>(to coordinator: T, _ navigationController: UINavigationController) {
        store(child: coordinator)
        coordinator.parent = self as? T.P
        coordinator.start(navigationController)
    }
}


private var identifierKey: UInt8 = 0
private var parentKey: UInt8 = 0
private var childrenKey: UInt8 = 0
