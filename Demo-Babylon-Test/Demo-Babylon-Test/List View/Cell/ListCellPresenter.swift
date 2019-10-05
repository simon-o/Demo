//
//  ListCellPresenter.swift
//  Demo-Babylon-Test
//
//  Created by Antoine Simon on 05/10/2019.
//  Copyright © 2019 antoine simon. All rights reserved.
//

import Foundation

protocol ListCellPresenterProtocol: AnyObject {
    
}

class ListCellPresenter {
    private weak var view: ListTableViewCellProtocol?
    private var firebaseManager: FirebaseManagerProtocol
    
    init(firebase: FirebaseManagerProtocol) {
        self.firebaseManager = firebase
    }
}

extension ListCellPresenter: ListCellPresenterProtocol {
    
}
