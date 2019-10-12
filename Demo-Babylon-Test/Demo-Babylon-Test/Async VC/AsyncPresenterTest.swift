//
//  AsyncPresenterTest.swift
//  Demo-Babylon-TestTests
//
//  Created by Antoine Simon on 12/10/2019.
//  Copyright © 2019 antoine simon. All rights reserved.
//

import XCTest
@testable import Demo_Babylon_Test

class AsyncPresenterTest: XCTestCase {

    var presenter: AsyncPresenter!
    
    override func setUp() {
        presenter = AsyncPresenter()
    }

    func testViewDidLoad() {
        let view = AsyncViewControllerMock()
        presenter.viewAttach(view: view)

        presenter.viewDidLoad()

        XCTAssertEqual(view.addText, nil)
        XCTAssertEqual(view.secondButtonTitle, "Type 2 Operation")
        XCTAssertEqual(view.buttonTitle, "Type 1 Operation")
    }
    
    func testManipulateText() {
        let view = AsyncViewControllerMock()
        presenter.viewAttach(view: view)

        presenter.viewDidLoad()
        XCTAssertEqual(view.addText, nil)
        
        view.clearText()
        XCTAssertEqual(view.addText, "")
        
        view.addTextView(text: "1")
        XCTAssertEqual(view.addText, "1")
        
        view.addTextView(text: "2")
        XCTAssertEqual(view.addText, "2")
        
        view.clearText()
        XCTAssertEqual(view.addText, "")
    }
}

class AsyncViewControllerMock: AsyncViewControllerProtocol {
    var addText: String?
    var secondButtonTitle: String?
    var buttonTitle: String?
    
    func setButton(title: String) { buttonTitle = title }
    func setSecondButton(title: String) { secondButtonTitle = title }
    func addTextView(text: String) { addText = text}
    func clearText() { addText = ""}
}
