//
//  LoginViewController.swift
//  Demo-Babylon-Test
//
//  Created by Antoine Simon on 28/09/2019.
//  Copyright © 2019 antoine simon. All rights reserved.
//

import UIKit

protocol LoginViewControllerProtocol: BaseViewControllerProtocol {
    func setTitle(_ title: String)
    func setRegisterButtonTitle(_ title: String)
    func setForgottenButtonTitle(_ title: String)
    func setLoginButtonTitle(_ title: String)
    func setUsernamePlaceHolder(_ placeHolder: String)
    func setPasswordPlaceHolder(_ placeHolder: String)
    func goToList()
    func goToRegister()
    func goToForgotten()
    
    func getEmail() -> String?
    func getPassword() -> String?
}

class LoginViewController: UIViewController {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var usernameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var registerButton: UIButton!
    @IBOutlet private weak var forgottenButton: UIButton!
    
    private var presenter: LoginPresenterProtocol
    
    init(presenter: LoginPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: String(describing: LoginViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.attachView(view: self)
        presenter.viewDidLoad()
    }

    @IBAction func registerClicked(_ sender: Any) {
        presenter.registerClicked()
    }
    
    @IBAction func forgottenClicked(_ sender: Any) {
        presenter.forgottenClicked()
    }
    
    @IBAction func loginClicked(_ sender: Any) {
        presenter.loginClicked()
    }
}

extension LoginViewController: LoginViewControllerProtocol {
    func getEmail() -> String? {
        return usernameTextField.text
    }
    
    func getPassword() -> String? {
        return passwordTextField.text
    }
    
    func goToList() {
        //TODO: Modal
//        navigationController?.present(<#T##viewControllerToPresent: UIViewController##UIViewController#>, animated: true, completion: nil)
    }
    
    func goToRegister() {
        let presenter = RegisterPresenter(firebase: FirebaseManagerAuth())
        let viewController = RegisterViewController(presenter: presenter)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func goToForgotten() {
        let presenter = ForgottenPasswordPresenter(firebase: FirebaseManagerAuth())
        let viewController = ForgottenPasswordViewController(presenter: presenter)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
    
    func setRegisterButtonTitle(_ title: String) {
        registerButton.setTitle(title, for: .normal)
    }
    
    func setForgottenButtonTitle(_ title: String) {
        forgottenButton.setTitle(title, for: .normal)
    }
    
    func setLoginButtonTitle(_ title: String) {
        loginButton.setTitle(title, for: .normal)
    }
    
    func setUsernamePlaceHolder(_ placeHolder: String) {
        usernameTextField.placeholder = placeHolder
    }
    
    func setPasswordPlaceHolder(_ placeHolder: String) {
        passwordTextField.placeholder = placeHolder
    }
}