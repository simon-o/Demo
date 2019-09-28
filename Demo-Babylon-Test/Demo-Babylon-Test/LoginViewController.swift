//
//  LoginViewController.swift
//  Demo-Babylon-Test
//
//  Created by Antoine Simon on 28/09/2019.
//  Copyright © 2019 antoine simon. All rights reserved.
//

import UIKit

protocol LoginVewControllerProtocol {
    func setTitle(_ title: String)
    func setRegisterButtonTitle(_ title: String)
    func setForgottenButtonTitle(_ title: String)
    func setLoginButtonTitle(_ title: String)
    func setUsernamePlaceHolder(_ placeHolder: String)
    func setPasswordPlaceHolder(_ placeHolder: String)
    func goToList()
    func goToRegister()
    func goToForgotten()
    func failedView()
}

class LoginViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var forgottenButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }


    @IBAction func registerClicked(_ sender: Any) {
        
    }
    @IBAction func forgottenClicked(_ sender: Any) {
        
    }
    @IBAction func loginClicked(_ sender: Any) {
        
    }
}

extension LoginViewController: LoginVewControllerProtocol {
    func failedView() {
        <#code#>
    }
    
    func goToList() {
        <#code#>
    }
    
    func goToRegister() {
        <#code#>
    }
    
    func goToForgotten() {
        <#code#>
    }
    
    func setTitle(_ title: String) {
        <#code#>
    }
    
    func setRegisterButtonTitle(_ title: String) {
        <#code#>
    }
    
    func setForgottenButtonTitle(_ title: String) {
        <#code#>
    }
    
    func setLoginButtonTitle(_ title: String) {
        <#code#>
    }
    
    func setUsernamePlaceHolder(_ placeHolder: String) {
        <#code#>
    }
    
    func setPasswordPlaceHolder(_ placeHolder: String) {
        <#code#>
    }
}
