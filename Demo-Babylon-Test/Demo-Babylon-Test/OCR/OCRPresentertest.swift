//
//  OCRPresentertest.swift
//  Demo-Babylon-TestTests
//
//  Created by Antoine Simon on 10/10/2019.
//  Copyright © 2019 antoine simon. All rights reserved.
//

import XCTest
@testable import Demo_Babylon_Test

class OCRPresenterTest: XCTestCase {
    var presenter: OCRPresenterProtocol!
    var fillName: String?
    
    override func setUp() {
        presenter = OCRPresenter(delegate: self)
    }
    
    func testViewDidLoad() {
        let view = OCRViewControllerMock()
        presenter.attachView(view: view)
        
        presenter.getInformation(data: "test")
        
        XCTAssertEqual(view.goBackCount, 0)
        XCTAssertEqual(self.fillName, nil)
        
        presenter.getInformation(data: "test")
        
        XCTAssertEqual(view.goBackCount, 0)
        XCTAssertEqual(self.fillName, nil)
        
        presenter.getInformation(data: "test1")
        
        XCTAssertEqual(view.goBackCount, 0)
        XCTAssertEqual(self.fillName, nil)
        
        presenter.getInformation(data: "test")
        
        XCTAssertEqual(view.goBackCount, 1)
        XCTAssertEqual(self.fillName, "test")
    }
}

class OCRViewControllerMock: OCRViewControllerProtocol {
    var goBackCount = 0
    
    func goBack() {
        goBackCount += 1
    }
}

extension OCRPresenterTest: OCRPresenterDelegate {
    func fillWith(name: String) {
        fillName = name
    }
}
