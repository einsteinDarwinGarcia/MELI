//
//  HomeViewController.swift
//  BasePoint
//
//  Created by Einstein Darwin Garcia Mendez on 11/05/21.
//

import UIKit

class HomeViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var inputText: UITextField!

    var viewModel: HomeViewModelImplementation?
    
    static func create(with viewModel: HomeViewModelImplementation) -> HomeViewController {
        let vc = HomeViewController.instantiate()
        vc.viewModel = viewModel
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let viewModel = self.viewModel else {
            fatalError("cant initialize the viewModel")
        }
        bind(to: viewModel)
        inputText.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        nextButton.addTarget(self, action: #selector(nextButtonAction), for: .touchDown)
    }
    
    func bind(to viewModel: HomeViewModelImplementation) {
        viewModel.messageAuthorized.observe(on: self) { [weak self] (value) in
            self?.updateMessage(text: value)
        }
        
        viewModel.activateButton.observe(on: self) { [weak self] (value) in
            self?.updateButtton(state: value)
        }
    }
    
    func updateMessage(text: String) {
        messageLabel.text = text
    }
    
    func updateButtton(state: Bool) {
        nextButton.isEnabled = state
    }
    
    @objc func textFieldDidChange(textField: UITextField) {
        guard let viewModel = viewModel, let text = textField.text else {
            return
        }
        
        viewModel.validateInput(text: text)
    }
    
    @objc func nextButtonAction() {
        guard let navigation = self.navigationController else {
            fatalError("lost Navigation controller")
        }
        goToFlow(with: navigation)
    }

}

// MARK: Navigation

extension HomeViewController: Navigation {
    func goToFlow(with navigation: UINavigationController) {
        viewModel?.goToFlow(with: navigation)
    }
}
