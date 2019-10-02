//
//  ForgottenPasswordPresenter.swift
//  Demo-Babylon-Test
//
//  Created by Antoine Simon on 02/10/2019.
//  Copyright © 2019 antoine simon. All rights reserved.
//

import Foundation

protocol ForgottenPasswordPresenterProtocol: AnyObject {
    func attachView(_ view: ForgottenPasswordViewControllerProtocol)
    func sendButtonClicked()
    func viewDidLoad()
}

final class ForgottenPasswordPresenter {
    private weak var view: ForgottenPasswordViewControllerProtocol?
    private var firebaseManager: FirebaseManagerAuth
    
    init(firebase: FirebaseManagerAuth) {
        self.firebaseManager = firebase
    }
}

extension ForgottenPasswordPresenter: ForgottenPasswordPresenterProtocol {
    func viewDidLoad() {
        view?.setEmailPlaceHolder("Enter your Email")
        view?.setButtonTitle("Send")
    }
    
    func attachView(_ view: ForgottenPasswordViewControllerProtocol) {
        self.view = view
    }
    
    func sendButtonClicked() {
        firebaseManager.forgottenPassword(email: view?.getEmailTextField() ?? "") { (error) in
            guard let error = error else {
                self.view?.goBack()
                return
            }
            self.view?.displayAlert(title: "Error", message: error.localizedDescription)
        }
    }
}
