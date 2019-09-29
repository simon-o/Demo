//
//  RegisterViewController.swift
//  Demo-Babylon-Test
//
//  Created by Antoine Simon on 28/09/2019.
//  Copyright © 2019 antoine simon. All rights reserved.
//

import UIKit

protocol RegisterViewControllerProtocol: AnyObject {
    func showAlert(title: String, message: String)
    func setUsernameTextField(placeHolder: String)
    func setPasswordTextField(placeHolder: String)
    func setRegisterButtonTitle(_ title: String)
}

class RegisterViewController: UIViewController {

    @IBOutlet private weak var usernameTextfield: UITextField!
    @IBOutlet private weak var passwordTextfield: UITextField!
    @IBOutlet private weak var registerButton: UIButton!
    
    let presenter: RegisterPresenterProtocol
    
    init(presenter: RegisterPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: String(describing: RegisterViewController.self), bundle: nil)
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

extension RegisterViewController: RegisterViewControllerProtocol {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func setUsernameTextField(placeHolder: String) {
        usernameTextfield.placeholder = placeHolder
    }
    
    func setPasswordTextField(placeHolder: String) {
        passwordTextfield.placeholder = placeHolder
    }
    
    func setRegisterButtonTitle(_ title: String) {
        registerButton.setTitle(title, for: .normal)
    }
}
