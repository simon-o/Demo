//
//  AsyncViewController.swift
//  Demo-Babylon-Test
//
//  Created by Antoine Simon on 11/10/2019.
//  Copyright © 2019 antoine simon. All rights reserved.
//

import UIKit

protocol AsyncViewControllerProtocol: AnyObject {
    
}

class AsyncViewController: UIViewController {
    private var presenter: AsyncPresenterProtocol
    
    init(presenter: AsyncPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: String(describing: AsyncViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewAttach(view: self)
        presenter.viewDidLoad()
    }

}

extension AsyncViewController: AsyncViewControllerProtocol {
    
}
