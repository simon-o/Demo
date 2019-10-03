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
    func addClicked() {
        view?.goToAddView()
    }
    
    func attachView(view: ListTableViewControllerProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        view?.setNavigationTitle("List")
        view?.setNavigationItem()
    }
}
