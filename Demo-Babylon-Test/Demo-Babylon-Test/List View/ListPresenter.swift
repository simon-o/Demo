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
}

final class ListPresenter {
    private weak var view: ListTableViewControllerProtocol?
    private var firebaseManager: FirebaseManagerAuth
    
    init(fireBase: FirebaseManagerAuth) {
        self.firebaseManager = fireBase
    }
}

extension ListPresenter: ListPresenterProtocol {
    func attachView(view: ListTableViewControllerProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        
    }
}
