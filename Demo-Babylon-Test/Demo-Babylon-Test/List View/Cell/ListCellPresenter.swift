//
//  ListCellPresenter.swift
//  Demo-Babylon-Test
//
//  Created by Antoine Simon on 05/10/2019.
//  Copyright © 2019 antoine simon. All rights reserved.
//

import Foundation

protocol ListCellPresenterProtocol: AnyObject {
    func editButtonClicked()
    func deleteButtonCLicked()
}

class ListCellPresenter {
    private weak var view: ListTableViewCellProtocol?
    private var firebaseManager: FirebaseManagerProtocol
    private var id: String
    
    init(firebase: FirebaseManagerProtocol, id: String) {
        self.firebaseManager = firebase
        self.id = id
    }
}

extension ListCellPresenter: ListCellPresenterProtocol {
    func editButtonClicked() {
        
    }
    
    func deleteButtonCLicked() {
        firebaseManager.removeValue(id: id) { (error, reference) in
            if let error = error {
                
            } else {
                
            }
        }
    }
}
