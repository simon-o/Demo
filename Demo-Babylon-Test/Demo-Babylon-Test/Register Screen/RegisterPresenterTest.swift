//
//  RegisterPresenterTest.swift
//  Demo-Babylon-TestTests
//
//  Created by Antoine Simon on 03/10/2019.
//  Copyright © 2019 antoine simon. All rights reserved.
//

import XCTest
@testable import Demo_Babylon_Test

class RegisterPresenterTest: XCTestCase {

    var presenter: RegisterPresenter!
    var firebaseManager: FirebaseManagerAuthMock!
    
    override func setUp() {
        firebaseManager = FirebaseManagerAuthMock()
        presenter = RegisterPresenter(firebase: firebaseManager)
    }

    func testViewDidLoad() {
        let view = RegisterViewControllerMock(email: "", password: "")
        presenter.attachView(view)

        presenter.viewDidLoad()

        XCTAssertEqual(view.usernamePlaceholder, "Set Email")
        XCTAssertEqual(view.passwordPlaceholder, "Set Password")
        XCTAssertEqual(view.registerButtonTitle, "Create Account")
        XCTAssertEqual(view.goBackCount, 0)
    }
    
    func testLoginClicked_success() {
        let view = RegisterViewControllerMock(email: "lol@lol.com", password: "123456789")
        presenter.attachView(view)
        
        firebaseManager.booleanReturn = true
        firebaseManager.stringErrorReturn = nil
            
        XCTAssertEqual(view.goBackCount, 0)
        presenter.registerButtonClicked()
        XCTAssertEqual(view.goBackCount, 1)
    }
    
    func testLoginClicked_failure() {
        let view = RegisterViewControllerMock(email: "lol@lol.com", password: "123456789")
        presenter.attachView(view)
        
        firebaseManager.booleanReturn = false
        firebaseManager.stringErrorReturn = "error"
            
        XCTAssertEqual(view.goBackCount, 0)
        presenter.registerButtonClicked()
        XCTAssertEqual(view.goBackCount, 0)
        XCTAssertEqual(view.alertMessage, "error")
    }
}

private class RegisterViewControllerMock: RegisterViewControllerProtocol {
    var usernamePlaceholder: String?
    var passwordPlaceholder: String?
    var registerButtonTitle: String?
    var goBackCount = 0
    
    let email: String
    let password: String
    
    var alertTitle: String?
    var alertMessage: String?
    var alertButtonTitle: String?
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
    
    func setUsernameTextField(placeHolder: String) { usernamePlaceholder = placeHolder }
    func setPasswordTextField(placeHolder: String) { passwordPlaceholder = placeHolder }
    func setRegisterButtonTitle(_ title: String) { registerButtonTitle = title }
    func getEmail() -> String? { return email}
    func getPassword() -> String? { return password}
    func goBack() { goBackCount += 1 }
    
    func alertView(title: String, message: String, buttonTitle: String) {
        self.alertTitle = title
        self.alertMessage = message
        self.alertButtonTitle = buttonTitle
    }
}
