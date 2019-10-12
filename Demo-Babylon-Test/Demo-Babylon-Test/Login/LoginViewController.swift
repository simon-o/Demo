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
    func setAsyncButton(title: String)
    func goToAsync()
    
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
    
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet weak var asyncButton: UIButton!
    
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
        
        presenter.attachView(view: self)
        presenter.viewDidLoad()
    }
    
    @objc func keyboardWillShow(notification:NSNotification){

        let userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)

        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        scrollView.contentInset = contentInset
    }

    @objc func keyboardWillHide(notification:NSNotification){

        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
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
    
    @IBAction func asyncButtonClicked(_ sender: Any) {
        presenter.asyncButtonClicked()
    }
}

extension LoginViewController: LoginViewControllerProtocol {
    func goToAsync() {
        let presenter = AsyncPresenter()
        let viewController = AsyncViewController(presenter: presenter)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func setAsyncButton(title: String) {
        asyncButton.setTitle(title, for: .normal)
    }
    
    func getEmail() -> String? {
        return usernameTextField.text
    }
    
    func getPassword() -> String? {
        return passwordTextField.text
    }
    
    func goToList() {
        let presenter = ListPresenter(fireBase: FirebaseManager())
        let viewController = ListTableViewController(presenter: presenter)
        let navigator = UINavigationController.init(rootViewController: viewController)
        navigator.modalPresentationStyle = .fullScreen
        navigationController?.present(navigator, animated: true, completion: nil)
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
