//
//  RegisterViewController.swift
//  Demo-Babylon-Test
//
//  Created by Antoine Simon on 28/09/2019.
//  Copyright © 2019 antoine simon. All rights reserved.
//

import UIKit

protocol RegisterViewControllerProtocol: BaseViewControllerProtocol {
    func setUsernameTextField(placeHolder: String)
    func setPasswordTextField(placeHolder: String)
    func setRegisterButtonTitle(_ title: String)
    
    func getEmail() -> String?
    func getPassword() -> String?
    
    func goBack()
}

final class RegisterViewController: UIViewController {

    @IBOutlet private weak var usernameTextfield: UITextField!
    @IBOutlet private weak var passwordTextfield: UITextField!
    @IBOutlet private weak var registerButton: UIButton!
    @IBOutlet private weak var scrollview: UIScrollView!
    
    private let presenter: RegisterPresenterProtocol
    
    init(presenter: RegisterPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: String(describing: RegisterViewController.self), bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
        
        presenter.attachView(self)
        presenter.viewDidLoad()
    }
    
    @objc func keyboardWillShow(notification:NSNotification){

        let userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)

        var contentInset:UIEdgeInsets = self.scrollview.contentInset
        contentInset.bottom = keyboardFrame.size.height
        scrollview.contentInset = contentInset
    }

    @objc func keyboardWillHide(notification:NSNotification){

        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollview.contentInset = contentInset
    }
    
    @IBAction func registerButtonClicked(_ sender: Any) {
        presenter.registerButtonClicked()
    }
}

extension RegisterViewController: RegisterViewControllerProtocol {
    func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    func getEmail() -> String? {
        return usernameTextfield.text
    }
    
    func getPassword() -> String? {
        return passwordTextfield.text
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
