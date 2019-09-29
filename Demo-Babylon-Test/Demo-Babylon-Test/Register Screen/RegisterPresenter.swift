//
//  RegisterPresenter.swift
//  Demo-Babylon-Test
//
//  Created by Antoine Simon on 28/09/2019.
//  Copyright © 2019 antoine simon. All rights reserved.
//

import Foundation

protocol RegisterPresenterProtocol: AnyObject {
    func viewDidLoad()
    func attachView(_ view: RegisterViewControllerProtocol)
    func registerButtonClicked()
}

class RegisterPresenter {
    weak var view: RegisterViewControllerProtocol?
    private var firebaseManager: FirebaseManagerAuth
    
    init(firebase: FirebaseManagerAuth) {
        self.firebaseManager = firebase
    }
}

extension RegisterPresenter: RegisterPresenterProtocol {
    func registerButtonClicked() {
        if let email = self.view?.getEmail(), let password = self.view?.getPassword() {
            FirebaseManagerAuth().createUser(email: email, password: password) { [weak self] (isSuccess, error) in
                if isSuccess {
                    self?.view?.goBack()
                } else {
                    self?.view?.displayAlert(title: "Error", message: error ?? "An error happened")
                }
            }
        }
    }
    
    func attachView(_ view: RegisterViewControllerProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        view?.setRegisterButtonTitle("Create Account")
        view?.setUsernameTextField(placeHolder: "Set Username")
        view?.setPasswordTextField(placeHolder: "Set Password")
        
        
    }
}
