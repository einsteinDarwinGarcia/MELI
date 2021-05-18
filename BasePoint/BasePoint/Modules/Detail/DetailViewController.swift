//
//  DetailViewController.swift
//  BasePoint
//
//  Created by Einstein Darwin Garcia Mendez on 17/05/21.
//

import UIKit

class DetailViewController: UIViewController, Storyboarded {

    @IBOutlet weak var messageLabel: UILabel!
    var viewModel: DetailVviewModelImplementation?
    
    static func create(with viewModel: DetailVviewModelImplementation) -> DetailViewController {
        let vc = DetailViewController.instantiate()
        vc.viewModel = viewModel
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let viewModel = self.viewModel else {
            fatalError("cant initialize the viewModel")
        }
        
        bind(to: viewModel)
    }
    
    func bind(to viewModel: DetailVviewModelImplementation) {
        viewModel.userLogged.observe(on: self) { [weak self] (value) in
            self?.messageLabel.text = value
        }
    }

}
