//
//  OCRPresenter.swift
//  Demo-Babylon-Test
//
//  Created by Antoine Simon on 09/10/2019.
//  Copyright © 2019 antoine simon. All rights reserved.
//

import Foundation

protocol OCRPresenterDelegate {
    func fillWith(name: String)
}
protocol OCRPresenterProtocol: AnyObject {
    func attachView(view: OCRViewControllerProtocol)
    func getInformtion(data: String)
}

class OCRPresenter {
    private weak var view: OCRViewControllerProtocol?
    private let delegate: OCRPresenterDelegate
    
    init(delegate: OCRPresenterDelegate) {
        self.delegate = delegate
    }
}

extension OCRPresenter: OCRPresenterProtocol {
    func getInformtion(data: String) {
        delegate.fillWith(name: data)
        view?.goBack()
    }
    
    func attachView(view: OCRViewControllerProtocol) {
        self.view = view
    }
}
