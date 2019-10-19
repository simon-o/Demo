//
//  ListPresenter.swift
//  Demo-Babylon-Test
//
//  Created by Antoine Simon on 02/10/2019.
//  Copyright © 2019 antoine simon. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

protocol ListPresenterProtocol: AnyObject {
    func viewDidLoad()
    func attachView(view: ListTableViewControllerProtocol)
    func buildCell(cell: ListTableViewCellProtocol, index: IndexPath)
    func addClicked()
    
    func getNumberSection() -> Int
    func getNumberRow(for section: Int) -> Int
}

final class ListPresenter {
    private weak var view: ListTableViewControllerProtocol?
    private var firebaseManager: FirebaseManagerProtocol
    private let listItemRX: BehaviorRelay<[ItemList]> = BehaviorRelay(value: [])
    private let disposeBag = DisposeBag()
    
    init(fireBase: FirebaseManagerProtocol) {
        self.firebaseManager = fireBase
    }
}

extension ListPresenter: ListPresenterProtocol {
    func getNumberSection() -> Int {
        return 1
    }
    
    func getNumberRow(for section: Int) -> Int{
        return listItemRX.value.count
    }
    
    //TODO: I can use completionBLock to send the action to attriubte to the button from this presenter
    func buildCell(cell: ListTableViewCellProtocol, index: IndexPath) {
        let items = listItemRX.value
        
        cell.setNameLabel(name: items[index.row].name)
        cell.setQuantityLabel(quantity: items[index.row].quantity)
            
        cell.editButton(title: "Edit")
        cell.deleteButton(title: "Delete")
        
        cell.setActionEdit {
            self.view?.goToEditView(item: items[index.row])
        }
        
        cell.setActionDelete {
            self.firebaseManager.removeValue(id: items[index.row].key) { (error, reference) in
                guard let error = error else { return }
                self.view?.alertView(title: "Error", message: error.localizedDescription, buttonTitle: "Ok")
            }
        }
    }
    
    func addClicked() {
        view?.goToAddView()
    }
    
    func attachView(view: ListTableViewControllerProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        listItemRX.asObservable().subscribe(onNext: { (list) in
            self.view?.setNavigationTitle("List (\(list.count))")
        }, onError: nil,
           onCompleted: nil,
           onDisposed: nil)
            .disposed(by: disposeBag)
        
        view?.setNavigationItem()
        
        firebaseManager.getListForUser { (itemsList) in
            self.listItemRX.accept(itemsList)
            self.view?.reload()
        }
    }
}
