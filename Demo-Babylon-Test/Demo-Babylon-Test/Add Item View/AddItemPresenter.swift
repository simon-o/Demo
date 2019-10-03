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
}

class AddItemPresenter: NSObject {
    private weak var view: AddItemViewControllerProtocol?
    private var firebaseManager: FirebaseManager
    
    init(fireBase: FirebaseManager) {
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
    
    func saveClicked() {
        //TODO: Save on firebase
    }
}
