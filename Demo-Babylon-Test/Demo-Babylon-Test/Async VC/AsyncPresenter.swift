//
//  AsyncPresenter.swift
//  Demo-Babylon-Test
//
//  Created by Antoine Simon on 11/10/2019.
//  Copyright © 2019 antoine simon. All rights reserved.
//

import Foundation
import Alamofire
import Dispatch

protocol AsyncPresenterProtocol {
    func viewDidLoad()
    func viewAttach(view: AsyncViewControllerProtocol)
    func buttonClicked()
    func secondButtonClicked()
}

final class AsyncPresenter {
    private weak var view: AsyncViewControllerProtocol?
    
    
    private func makeGet(completion: @escaping () -> Void) {
        AF.request("https://httpbin.org/get", parameters: ["foo":"bar"]).response { _ in
            completion()
        }
    }
    
    private func makePost(completion: @escaping () -> Void) {
        AF.request("https://httpbin.org/post", method: .post).response { _ in
            completion()
        }
    }
}

extension AsyncPresenter: AsyncPresenterProtocol {
    func secondButtonClicked() {
        view?.clearText()
        let queue = OperationQueue()
        
        let op1 = BlockOperation {
            for _ in 0 ... 10
            {
                DispatchQueue.main.async {
                self.view?.addTextView(text:"1")
                }
            }
        }
        let op2 = BlockOperation {
            for _ in 0 ... 5
            {
                DispatchQueue.main.async {
                self.view?.addTextView(text:"2")
                }
            }
        }
        let op3 = BlockOperation {
            for _ in 0 ... 20
            {
                DispatchQueue.main.async {
                self.view?.addTextView(text:"3")
                }
            }
        }
        
        queue.maxConcurrentOperationCount = 1
        op3.addDependency(op1)
        op3.addDependency(op2)
        op2.addDependency(op1)
        queue.addOperations([op1, op2, op3], waitUntilFinished: false)
    }
    
    func buttonClicked() {
        view?.clearText()
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        makeGet {
            self.view?.addTextView(text: "get")
            dispatchGroup.leave()
        }
        makePost {
            self.view?.addTextView(text: "post")
            dispatchGroup.leave()
        }
        dispatchGroup.enter()
        
        dispatchGroup.notify(queue: .main) {
            self.view?.addTextView(text: "all request finished type 1")
        }
    }
    
    func viewAttach(view: AsyncViewControllerProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        view?.setButton(title: "Type 1 Operation")
        view?.setSecondButton(title: "Type 2 Operation")
    }
}
