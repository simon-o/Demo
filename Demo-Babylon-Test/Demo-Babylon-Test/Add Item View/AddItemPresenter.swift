//
//  AddItemPresenter.swift
//  Demo-Babylon-Test
//
//  Created by Antoine Simon on 03/10/2019.
//  Copyright © 2019 antoine simon. All rights reserved.
//

import Foundation

protocol AddItemPresenterProtocol: AnyObject {
    func attachView(_ view: AddItemViewControllerProtocol)
    func viewDidLoad()
    func saveClicked(id: String?)
}

class AddItemPresenter {
    private weak var view: AddItemViewControllerProtocol?
    private var firebaseManager: FirebaseManagerProtocol
    
    init(fireBase: FirebaseManagerProtocol) {
        self.firebaseManager = fireBase
    }
}

extension AddItemPresenter: AddItemPresenterProtocol {
    func attachView(_ view: AddItemViewControllerProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        view?.setNavigationItem()
        view?.setNameTextfieldPlaceholder(text: "Name Item")
        view?.setQuantityTextfieldPlaceholder(text: "Quantity")
    }
    
    func saveClicked(id: String?) {
        guard let nameItem = view?.getNameTextfield(), let quantityItem = view?.getQuantityTextfield() else { return }
        if let id = id {
            firebaseManager.updateValue(id: id, name: nameItem, quantity: quantityItem) { (error, reference) in
                if let error = error {
                    self.view?.alertView(title: "Error", message: error.localizedDescription, buttonTitle: "Ok")
                } else {
                    self.view?.goBack()
                }
            }
        } else {
            firebaseManager.addValue(name: nameItem, quantity: quantityItem) { (error, reference) in
                if let error = error {
                    self.view?.alertView(title: "Error", message: error.localizedDescription, buttonTitle: "Ok")
                } else {
                    self.view?.goBack()
                }
            }
        }
    }
}
