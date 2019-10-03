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

final class RegisterPresenter {
    private weak var view: RegisterViewControllerProtocol?
    private var firebaseManager: FirebaseManagerAuthProtocol
    
    init(firebase: FirebaseManagerAuthProtocol) {
        self.firebaseManager = firebase
    }
}

extension RegisterPresenter: RegisterPresenterProtocol {
    func registerButtonClicked() {
        if let email = self.view?.getEmail(), let password = self.view?.getPassword() {
            firebaseManager.createUser(email: email, password: password) { [weak self] (isSuccess, error) in
                guard let self = self else { return }
                if isSuccess {
                    self.view?.goBack()
                } else {
                    self.view?.alertView(title: "Error", message: error ?? "An error happened", buttonTitle: "Ok")
                }
            }
        }
    }
    
    func attachView(_ view: RegisterViewControllerProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        view?.setRegisterButtonTitle("Create Account")
        view?.setUsernameTextField(placeHolder: "Set Email")
        view?.setPasswordTextField(placeHolder: "Set Password")
        
        
    }
}
