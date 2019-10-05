//
//  ListPresenter.swift
//  Demo-Babylon-Test
//
//  Created by Antoine Simon on 02/10/2019.
//  Copyright © 2019 antoine simon. All rights reserved.
//

import Foundation

protocol ListPresenterProtocol: AnyObject {
    func viewDidLoad()
    func attachView(view: ListTableViewControllerProtocol)
    func buildCell(cell: ListTableViewCellProtocol, index: IndexPath)
    func addClicked()
}

final class ListPresenter {
    private weak var view: ListTableViewControllerProtocol?
    private var firebaseManager: FirebaseManager
    
    init(fireBase: FirebaseManager) {
        self.firebaseManager = fireBase
    }
}

extension ListPresenter: ListPresenterProtocol {
    //TODO: I can use completionBLock to send the action to attriubte to the button from this presenter
    func buildCell(cell: ListTableViewCellProtocol, index: IndexPath) {
        cell.setNameLabel(name: "pain")
        cell.setQuantityLabel(quantity: "1")
        
        cell.editButton(title: "Edit")
        cell.deleteButton(title: "Delete")
    }
    
    func addClicked() {
        view?.goToAddView()
    }
    
    func attachView(view: ListTableViewControllerProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        view?.setNavigationTitle("List")
        view?.setNavigationItem()
        
        //TODO: Call get list
    }
}
