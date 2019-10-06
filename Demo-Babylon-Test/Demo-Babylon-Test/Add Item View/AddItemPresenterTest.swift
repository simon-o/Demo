//
//  AddItemPresenterTest.swift
//  Demo-Babylon-TestTests
//
//  Created by Antoine Simon on 04/10/2019.
//  Copyright © 2019 antoine simon. All rights reserved.
//

import XCTest
import FirebaseDatabase
@testable import Demo_Babylon_Test

class AddItemPresenterTest: XCTestCase {

    var presenterAdd: AddItemPresenter!
    var presenterEdit: AddItemPresenter!
    var firebaseManager: FirebaseManagerMock!
    
    override func setUp() {
        firebaseManager = FirebaseManagerMock()
        presenterAdd = AddItemPresenter(fireBase: firebaseManager, item: nil)
        
        let list = ItemList(name: "bread", quantity: "1", key: "123456")
        presenterEdit = AddItemPresenter(fireBase: firebaseManager, item: list)
    }
    
    func testViewDidLoad_add() {
        let view = AddItemViewController(name: "", quantity: "")
        presenterAdd.attachView(view)
        
        presenterAdd.viewDidLoad()
        
        XCTAssertNil(view.nameText)
        XCTAssertNil(view.quantityText)
        XCTAssertEqual(view.goBackCount, 0)
        XCTAssertNil(view.alertTitle)
        XCTAssertNil(view.alertMessage)
        XCTAssertNil(view.alertButton)
        XCTAssertEqual(view.navigationItemCount, 1)
        XCTAssertEqual(view.namePlaceholder, "Name Item")
        XCTAssertEqual(view.quantityPlaceholder, "Quantity")
        XCTAssertEqual(view.name, "")
        XCTAssertEqual(view.quantity, "")
    }
    
    func testViewDidLoad_edit() {
        let view = AddItemViewController(name: "", quantity: "")
        presenterEdit.attachView(view)
        
        presenterEdit.viewDidLoad()
        
        XCTAssertEqual(view.nameText, "bread")
        XCTAssertEqual(view.quantityText, "1")
        XCTAssertEqual(view.goBackCount, 0)
        XCTAssertNil(view.alertTitle)
        XCTAssertNil(view.alertMessage)
        XCTAssertNil(view.alertButton)
        XCTAssertEqual(view.navigationItemCount, 1)
        XCTAssertEqual(view.namePlaceholder, "Name Item")
        XCTAssertEqual(view.quantityPlaceholder, "Quantity")
        XCTAssertEqual(view.name, "")
        XCTAssertEqual(view.quantity, "")
        
    }
    
    func testSavedClicked_add_success() {
        let view = AddItemViewController(name: "", quantity: "")
        presenterAdd.attachView(view)
        
        firebaseManager.errorReturn = nil
        firebaseManager.dataReferenceReturn = DatabaseReference.init()
        
        presenterAdd.viewDidLoad()
        
        XCTAssertEqual(view.goBackCount, 0)
        presenterAdd.saveClicked()
        XCTAssertEqual(view.goBackCount, 1)
    }
    
    func testSavedClicked_edit_success() {
        let view = AddItemViewController(name: "", quantity: "")
        presenterEdit.attachView(view)
        
        firebaseManager.errorReturn = nil
        firebaseManager.dataReferenceReturn = DatabaseReference.init()
        
        presenterEdit.viewDidLoad()
        
        XCTAssertEqual(view.goBackCount, 0)
        presenterEdit.saveClicked()
        XCTAssertEqual(view.goBackCount, 1)
    }
    
    func testSavedClicked_add_fail() {
        let view = AddItemViewController(name: "", quantity: "")
        presenterAdd.attachView(view)
        
        firebaseManager.errorReturn = errorMock.error
        firebaseManager.dataReferenceReturn = DatabaseReference.init()
        
        presenterAdd.viewDidLoad()
        
        XCTAssertEqual(view.goBackCount, 0)
        presenterAdd.saveClicked()
        XCTAssertEqual(view.goBackCount, 0)
    }
    
    func testSavedClicked_edit_fail() {
        let view = AddItemViewController(name: "", quantity: "")
        presenterEdit.attachView(view)
        
        firebaseManager.errorReturn = errorMock.error
        firebaseManager.dataReferenceReturn = DatabaseReference.init()
        
        presenterEdit.viewDidLoad()
        
        XCTAssertEqual(view.goBackCount, 0)
        presenterEdit.saveClicked()
        XCTAssertEqual(view.goBackCount, 0)
    }
}

class AddItemViewController: AddItemViewControllerProtocol {
    var nameText: String?
    var quantityText: String?
    var goBackCount = 0
    var alertTitle: String?
    var alertMessage: String?
    var alertButton: String?
    var navigationItemCount = 0
    var namePlaceholder: String?
    var quantityPlaceholder: String?
    
    var name: String
    var quantity: String
    
    init(name: String, quantity: String) {
        self.name = name
        self.quantity = quantity
    }
    
    func setNameTextfieldText(text: String) { nameText = text }
    func setQuantityTextfield(text: String) { quantityText = text }
    func goBack() { goBackCount += 1 }
    func alertView(title: String, message: String, buttonTitle: String) {
        alertTitle = title
        alertMessage = message
        alertButton = buttonTitle
    }
    func setNavigationItem() { navigationItemCount += 1 }
    func setNameTextfieldPlaceholder(text: String) { namePlaceholder = text}
    func setQuantityTextfieldPlaceholder(text: String) { quantityPlaceholder = text}
    func getNameTextfield() -> String { return name}
    func getQuantityTextfield() -> String { return quantity}
}
