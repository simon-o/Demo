//
//  ForgottenPasswordPresenterTest.swift
//  Demo-Babylon-TestTests
//
//  Created by Antoine Simon on 04/10/2019.
//  Copyright © 2019 antoine simon. All rights reserved.
//

import XCTest
@testable import Demo_Babylon_Test

enum errorMock: Error {
    case error
}

class ForgottenPasswordPresenterTest: XCTestCase {

    var presenter: ForgottenPasswordPresenter!
    var firebaseManager: FirebaseManagerAuthMock!
    
    override func setUp() {
        firebaseManager = FirebaseManagerAuthMock()
        presenter = ForgottenPasswordPresenter(firebase: firebaseManager)
    }

    func testViewDidLoad() {
        let view = ForgottenPasswordViewControllerMock(email: "123456")
        presenter.attachView(view)
        
        presenter.viewDidLoad()
        
        XCTAssertEqual(view.email, "123456")
        XCTAssertEqual(view.goBackCount, 0)
        XCTAssertEqual(view.emailPlaceholder, "Enter your Email")
        XCTAssertEqual(view.buttonTitle, "Send")
        XCTAssertNil(view.alertTitle)
        XCTAssertNil(view.alertButton)
        XCTAssertNil(view.alertMessage)
    }
    
    func testFireBase_success() {
        let view = ForgottenPasswordViewControllerMock(email: "lol@lol.com")
        presenter.attachView(view)
        
        firebaseManager.errorReturn = nil
            
        XCTAssertEqual(view.goBackCount, 0)
        presenter.sendButtonClicked()
        XCTAssertEqual(view.goBackCount, 1)
    }
    
    func testFireBase_failed() {
        let view = ForgottenPasswordViewControllerMock(email: "lol@lol.com")
        presenter.attachView(view)
        
        firebaseManager.errorReturn = errorMock.error
            
        XCTAssertEqual(view.goBackCount, 0)
        presenter.sendButtonClicked()
        XCTAssertEqual(view.goBackCount, 0)
    }
}

class ForgottenPasswordViewControllerMock: ForgottenPasswordViewControllerProtocol {
    let email: String
    
    var goBackCount = 0
    var emailPlaceholder: String?
    var buttonTitle: String?
    
    var alertTitle: String?
    var alertMessage: String?
    var alertButton: String?
    
    func goBack() {
        goBackCount += 1
    }
    
    func setEmailPlaceHolder(_ placeHolder: String) {
        emailPlaceholder = placeHolder
    }
    
    func setButtonTitle(_ title: String) {
        buttonTitle = title
    }
    
    func getEmailTextField() -> String? {
        return email
    }
    
    func alertView(title: String, message: String, buttonTitle: String) {
        alertTitle = title
        alertMessage = message
        alertButton = buttonTitle
    }
    
    init(email: String) {
        self.email = email
    }
}
