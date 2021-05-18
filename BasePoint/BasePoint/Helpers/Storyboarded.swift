//
//  Storyboarded.swift
//  BasePoint
//
//  Created by Einstein Darwin Garcia Mendez on 11/05/21.
//

import Foundation
import UIKit

protocol Storyboarded {
    associatedtype ViewModel
    associatedtype ViewController where ViewController: UIViewController
    
    var viewModel: ViewModel? { get set }
    static func create(with viewModel: ViewModel) -> ViewController
    
    static var defaultFileName: String { get }
    static func instantiate(_ bundle: Bundle?) -> Self
}

extension Storyboarded where Self: UIViewController {
    static var defaultFileName: String {
        guard let fileName = NSStringFromClass(Self.self).components(separatedBy: ".").last else {
            fatalError("Cannot instantiate initial view controller \(Self.self) from class ")
        }
        return fileName
    }
    static func instantiate(_ bundle: Bundle? = nil) -> Self {
        let fileName = defaultFileName
        let uiStoryboard = UIStoryboard(name: fileName, bundle: nil)
        guard let viewController = uiStoryboard.instantiateInitialViewController() as? Self else {
            fatalError("Cannot instantiate initial view controller \(Self.self) from storyboard with name \(fileName)")
        }

        return viewController
    }
}
