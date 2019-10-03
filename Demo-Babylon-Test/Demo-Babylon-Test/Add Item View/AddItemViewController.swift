//
//  AddItemViewController.swift
//  Demo-Babylon-Test
//
//  Created by Antoine Simon on 03/10/2019.
//  Copyright © 2019 antoine simon. All rights reserved.
//

import UIKit

protocol AddItemViewControllerProtocol: AnyObject {
    
}

class AddItemViewController: UIViewController {

    private let presenter: AddItemPresenterProtocol
    
    init(presenter: AddItemPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: String(describing: AddItemViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.attachView(self)
        presenter.viewDidLoad()
    }
}

extension AddItemViewController: AddItemViewControllerProtocol {
    
}
