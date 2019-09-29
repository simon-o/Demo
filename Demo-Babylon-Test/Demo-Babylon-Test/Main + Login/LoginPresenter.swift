//
//  LoginPresenter.swift
//  Demo-Babylon-Test
//
//  Created by Antoine Simon on 28/09/2019.
//  Copyright © 2019 antoine simon. All rights reserved.
//

import Foundation

protocol LoginPresenterProtocol: AnyObject {
    func attachView(view: LoginViewControllerProtocol)
    func loginClicked()
    func registerClicked()
    func forgottenClicked()
    func viewDidLoad()
}

final class LoginPresenter {
    private weak var view: LoginViewControllerProtocol?
    //TODO: Need to be init with the model
    init() {
        
    }
}

extension LoginPresenter: LoginPresenterProtocol {
    func viewDidLoad() {
        view?.setTitle("Welcome on my list Demo")
        view?.setLoginButtonTitle("Login")
        view?.setForgottenButtonTitle("Forgotten password")
        view?.setRegisterButtonTitle("Register")
        view?.setUsernamePlaceHolder("Enter Email")
        view?.setPasswordPlaceHolder("Enter Password")
    }
    
    func attachView(view: LoginViewControllerProtocol) {
        self.view = view
    }
    
    func loginClicked() {
        view?.failedView(title: "LOL", message: "toto")
    }
    
    func registerClicked() {
        view?.goToRegister()
    }
    
    func forgottenClicked() {
        view?.goToForgotten()
    }
    
    
}
