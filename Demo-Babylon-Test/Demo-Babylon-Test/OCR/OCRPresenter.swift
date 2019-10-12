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
    func getInformation(data: String)
}

final class OCRPresenter {
    private weak var view: OCRViewControllerProtocol?
    private let delegate: OCRPresenterDelegate
    private var array: [String] = []
    
    init(delegate: OCRPresenterDelegate) {
        self.delegate = delegate
    }
    
    private func checkValue(data: String) -> Bool{
        array.append(data)
        let counts = array.reduce(into: [:]) { counts, word in counts[word, default: 0] += 1 }
        
        for (_ , value) in counts {
            if value > 2 {
                return true
            }
        }
        return false
    }
}

extension OCRPresenter: OCRPresenterProtocol {
    func getInformation(data: String) {
        if checkValue(data: data) == true {
            delegate.fillWith(name: data)
            view?.goBack()
        }
    }
    
    func attachView(view: OCRViewControllerProtocol) {
        self.view = view
    }
}

