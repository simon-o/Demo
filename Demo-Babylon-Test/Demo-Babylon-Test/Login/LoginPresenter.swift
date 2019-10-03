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
    private var firebaseManager: FirebaseManagerAuthProtocol
    
    init(fireBase: FirebaseManagerAuthProtocol) {
        self.firebaseManager = fireBase
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
        firebaseManager.authentication(email: view?.getEmail() ?? "", password: view?.getPassword() ?? "") { [weak self] (isSuccess, error) in
            guard let self = self else { return }
            if isSuccess {
                self.view?.goToList()
            } else {
                self.view?.alertView(title: "Error", message: error ?? "An error happened", buttonTitle: "Ok")
            }
        }
    }
    
    func registerClicked() {
        view?.goToRegister()
    }
    
    func forgottenClicked() {
        view?.goToForgotten()
    }
}
