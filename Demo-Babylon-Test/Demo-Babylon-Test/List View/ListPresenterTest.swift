//
//  ListPresenterTest.swift
//  Demo-Babylon-TestTests
//
//  Created by Antoine Simon on 06/10/2019.
//  Copyright © 2019 antoine simon. All rights reserved.
//

import XCTest
import FirebaseDatabase
@testable import Demo_Babylon_Test

class ListPresenterTest: XCTestCase {

    var presenter: ListPresenter!
    var firebaseManager: FirebaseManagerMock!
    
    override func setUp() {
        firebaseManager = FirebaseManagerMock()
        firebaseManager.listReturn = [ItemList(name: "bread", quantity: "1", key: "123456")]

        presenter = ListPresenter(fireBase: firebaseManager)
    }

    func testViewDidLoad() {
        let view = ListTableViewControllerMock()
        presenter.attachView(view: view)
        
        presenter.viewDidLoad()
        
        XCTAssertEqual(view.reloadCount, 1)
        XCTAssertEqual(view.navigationTitle, "List")
        XCTAssertEqual(view.navigationItemCount, 1)
        XCTAssertEqual(view.goToAddViewCount, 0)
        XCTAssertEqual(view.goToEditViewCount, 0)
    }
    
    func testAddButton() {
        let view = ListTableViewControllerMock()
        presenter.attachView(view: view)
        
        presenter.viewDidLoad()
        
        XCTAssertEqual(view.reloadCount, 1)
        XCTAssertEqual(view.goToAddViewCount, 0)
        XCTAssertEqual(view.goToEditViewCount, 0)
        
        presenter.addClicked()
        
        XCTAssertEqual(view.reloadCount, 1)
        XCTAssertEqual(view.goToAddViewCount, 1)
        XCTAssertEqual(view.goToEditViewCount, 0)
    }
    
    func testBuildCell() {
        let view = ListTableViewControllerMock()
        let cell = ListTableViewCellMock()
        presenter.attachView(view: view)
        
        presenter.viewDidLoad()
        
        presenter.buildCell(cell: cell, index: IndexPath(row: 0, section: 0))
        
        XCTAssertEqual(cell.nameLabel, "bread")
        XCTAssertEqual(cell.quantityLabel, "1")
        XCTAssertEqual(cell.editButtonTitle, "Edit")
        XCTAssertEqual(cell.deleteButtonTitle, "Delete")
        
        XCTAssertNotNil(cell.actionEdit)
        XCTAssertNotNil(cell.actionDelete)
    }
    
    func testEditCell_success() {
        let view = ListTableViewControllerMock()
        let cell = ListTableViewCellMock()
        presenter.attachView(view: view)
        
        presenter.viewDidLoad()
        
        presenter.buildCell(cell: cell, index: IndexPath(row: 0, section: 0))
        
        XCTAssertEqual(view.reloadCount, 1)
        XCTAssertEqual(view.goToAddViewCount, 0)
        XCTAssertEqual(view.goToEditViewCount, 0)
        
        cell.actionEdit!()
        
        XCTAssertEqual(view.reloadCount, 1)
        XCTAssertEqual(view.goToAddViewCount, 0)
        XCTAssertEqual(view.goToEditViewCount, 1)
    }
    
    func testDeleteCell_fail() {
        let view = ListTableViewControllerMock()
        let cell = ListTableViewCellMock()
        presenter.attachView(view: view)
        firebaseManager.errorReturn = errorMock.error
        firebaseManager.dataReferenceReturn = DatabaseReference.init()
        
        presenter.viewDidLoad()
        
        presenter.buildCell(cell: cell, index: IndexPath(row: 0, section: 0))
        
        XCTAssertEqual(view.reloadCount, 1)
        XCTAssertEqual(view.goToAddViewCount, 0)
        XCTAssertEqual(view.goToEditViewCount, 0)
        XCTAssertEqual(view.alertTitle, nil)
        XCTAssertEqual(view.alertMessage, nil)
        XCTAssertEqual(view.alertButton, nil)
        
        cell.actionDelete!()
        
        XCTAssertEqual(view.reloadCount, 1)
        XCTAssertEqual(view.goToAddViewCount, 0)
        XCTAssertEqual(view.goToEditViewCount, 0)
        XCTAssertEqual(view.alertTitle, "Error")
        XCTAssertNotNil(view.alertMessage)
        XCTAssertEqual(view.alertButton, "Ok")
    }
    
    func testDeleteCell_success() {
        let view = ListTableViewControllerMock()
        let cell = ListTableViewCellMock()
        presenter.attachView(view: view)
        firebaseManager.errorReturn = nil
        firebaseManager.dataReferenceReturn = DatabaseReference.init()
        
        presenter.viewDidLoad()
        
        presenter.buildCell(cell: cell, index: IndexPath(row: 0, section: 0))
        
        XCTAssertEqual(view.reloadCount, 1)
        XCTAssertEqual(view.goToAddViewCount, 0)
        XCTAssertEqual(view.goToEditViewCount, 0)
        XCTAssertEqual(view.alertTitle, nil)
        XCTAssertEqual(view.alertMessage, nil)
        XCTAssertEqual(view.alertButton, nil)
        
        cell.actionDelete!()
        
        XCTAssertEqual(view.reloadCount, 1)
        XCTAssertEqual(view.goToAddViewCount, 0)
        XCTAssertEqual(view.goToEditViewCount, 0)
        XCTAssertEqual(view.alertTitle, nil)
        XCTAssertEqual(view.alertMessage, nil)
        XCTAssertEqual(view.alertButton, nil)
    }
}

class ListTableViewControllerMock: ListTableViewControllerProtocol {
    var reloadCount = 0
    var navigationTitle: String?
    var navigationItemCount = 0
    var goToAddViewCount = 0
    var goToEditViewCount = 0
    
    var alertTitle: String?
    var alertMessage: String?
    var alertButton: String?
    
    func reload() { reloadCount += 1 }
    func setNavigationTitle(_ title: String) { navigationTitle = title }
    func setNavigationItem() { navigationItemCount += 1 }
    func setNavigationItemCounter() {  }
    func goToAddView() { goToAddViewCount += 1 }
    func goToEditView(item: ItemList) { goToEditViewCount += 1}
    func alertView(title: String, message: String, buttonTitle: String) {
        alertTitle = title
        alertMessage = message
        alertButton = buttonTitle
    }
}

class ListTableViewCellMock: ListTableViewCellProtocol {
    var nameLabel: String?
    var quantityLabel: String?
    var editButtonTitle: String?
    var deleteButtonTitle: String?
    
    var actionEdit: (() -> Void)?
    var actionDelete: (() -> Void)?
    
    func setNameLabel(name: String) { nameLabel = name }
    func setQuantityLabel(quantity: String) { quantityLabel = quantity }
    func editButton(title: String) { editButtonTitle = title }
    func deleteButton(title: String) { deleteButtonTitle = title }
    func setActionEdit(completion: @escaping (() -> Void)) { actionEdit = completion }
    func setActionDelete(completion: @escaping (() -> Void)) { actionDelete = completion }
}
