//
//  LoginPresenterTest.swift
//  Demo-Babylon-TestTests
//
//  Created by Antoine Simon on 03/10/2019.
//  Copyright © 2019 antoine simon. All rights reserved.
//

import XCTest
@testable import Demo_Babylon_Test

class LoginPresenterTest: XCTestCase {

    var presenter: LoginPresenter!
    var firebaseManager: FirebaseManagerAuthMock!
    
    override func setUp() {
        firebaseManager = FirebaseManagerAuthMock()
        presenter = LoginPresenter(fireBase: firebaseManager)
    }

    func testViewDidLoad() {
        let view = LoginViewControllerMock(email: "", password: "")
        presenter.attachView(view: view)
        
        presenter.viewDidLoad()
        
        XCTAssertEqual(view.title, "Welcome on my list Demo")
        XCTAssertEqual(view.loginButtonTitle, "Login")
        XCTAssertEqual(view.forgottenButtonTitle, "Forgotten password")
        XCTAssertEqual(view.registerButtonTitle, "Register")
        XCTAssertEqual(view.userNamePlaceholder, "Enter Email")
        XCTAssertEqual(view.passwordPlaceholder, "Enter Password")
    }

    func testAlertView() {
        let view = LoginViewControllerMock(email: "", password: "")
        presenter.attachView(view: view)
        
        view.alertView(title: "test", message: "message", buttonTitle: "button")
        
        XCTAssertEqual(view.alertTitle, "test")
        XCTAssertEqual(view.alertMessage, "message")
        XCTAssertEqual(view.alertButtonTitle, "button")
    }
    
    func testLoginClicked_success() {
        let view = LoginViewControllerMock(email: "lol@lol.com", password: "123456789")
        presenter.attachView(view: view)
        
        firebaseManager.booleanReturn = true
        firebaseManager.stringErrorReturn = nil
            
        XCTAssertEqual(view.goToListCount, 0)
        presenter.loginClicked()
        XCTAssertEqual(view.goToListCount, 1)
    }
    
    func testLoginClicked_failure() {
        let view = LoginViewControllerMock(email: "lol@lol.com", password: "123456789")
        presenter.attachView(view: view)
        
        firebaseManager.booleanReturn = false
        firebaseManager.stringErrorReturn = "error"
            
        XCTAssertEqual(view.goToListCount, 0)
        presenter.loginClicked()
        XCTAssertEqual(view.goToListCount, 0)
        XCTAssertEqual(view.alertMessage, "error")
    }
}

private class LoginViewControllerMock: LoginViewControllerProtocol {
    var title: String?
    var registerButtonTitle: String?
    var forgottenButtonTitle: String?
    var loginButtonTitle: String?
    var userNamePlaceholder: String?
    var passwordPlaceholder: String?
    var goToListCount = 0
    var goToRegisterCount = 0
    var goToForgottenCount = 0
    
    var alertTitle: String?
    var alertMessage: String?
    var alertButtonTitle: String?
    
    let email: String
    let password: String
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
    
    
    func setTitle(_ title: String) { self.title = title }
    func setRegisterButtonTitle(_ title: String) { registerButtonTitle = title }
    func setForgottenButtonTitle(_ title: String) { forgottenButtonTitle = title }
    func setLoginButtonTitle(_ title: String) { loginButtonTitle = title }
    func setUsernamePlaceHolder(_ placeHolder: String) { userNamePlaceholder = placeHolder }
    func setPasswordPlaceHolder(_ placeHolder: String) { passwordPlaceholder = placeHolder }
    func goToList() { goToListCount += 1 }
    func goToRegister() { goToRegisterCount += 1}
    func goToForgotten() { goToForgottenCount += 1 }
    func getEmail() -> String? { return email}
    func getPassword() -> String? { return password }
    func alertView(title: String, message: String, buttonTitle: String) {
        self.alertTitle = title
        self.alertMessage = message
        self.alertButtonTitle = buttonTitle
    }
}
