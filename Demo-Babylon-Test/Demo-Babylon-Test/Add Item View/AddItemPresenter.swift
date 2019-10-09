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
    func saveClicked()
    func buttonCLicked()
}

class AddItemPresenter {
    private weak var view: AddItemViewControllerProtocol?
    private var firebaseManager: FirebaseManagerProtocol
    private var item: ItemList?
    
    init(fireBase: FirebaseManagerProtocol, item: ItemList?) {
        self.firebaseManager = fireBase
        self.item = item
    }
}

extension AddItemPresenter: AddItemPresenterProtocol {
    func buttonCLicked() {
        view?.goToOCR()
    }
    
    func attachView(_ view: AddItemViewControllerProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        view?.setNavigationItem()
        view?.setNameTextfieldPlaceholder(text: "Name Item")
        view?.setQuantityTextfieldPlaceholder(text: "Quantity")
        view?.setButtonTitle(title: "OCR")
        
        guard let item = item else { return }
        view?.setNameTextfieldText(text: item.name)
        view?.setQuantityTextfield(text: item.quantity)
        
    }
    
    func saveClicked() {
        guard let nameItem = view?.getNameTextfield(), let quantityItem = view?.getQuantityTextfield() else { return }
        if let id = self.item?.key {
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
