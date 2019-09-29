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
}

final class RegisterPresenter {
    weak var view: RegisterViewControllerProtocol?
    
    
}

extension RegisterPresenter: RegisterPresenterProtocol {
    func attachView(_ view: RegisterViewControllerProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        view?.setRegisterButtonTitle("Create Account")
        view?.setUsernameTextField(placeHolder: "Set Username")
        view?.setPasswordTextField(placeHolder: "Set Password")
    }
}
