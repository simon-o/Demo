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
}

final class AsyncPresenter {
    private weak var view: AsyncViewControllerProtocol?
    
    @IBOutlet weak var button: UIButton!
    private func makeGet(completion: @escaping () -> Void) {
        AF.request("https://httpbin.org/get").response { response in
            debugPrint(response)
            completion()
        }
    }
    
    private func makePost(completion: @escaping () -> Void) {
        AF.request("https://httpbin.org/post", method: .post).response { response in
            debugPrint(response)
            completion()
        }
    }
    
    @IBAction func buttonClicked(_ sender: Any) {
        
    }
}

extension AsyncPresenter: AsyncPresenterProtocol {
    func viewAttach(view: AsyncViewControllerProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
//        let dispatchGroup = DispatchGroup()
//        
//        dispatchGroup.enter()
//        makeGet {
//            dispatchGroup.leave()
//        }
//        
//        dispatchGroup.enter()
//        makePost {
//            dispatchGroup.leave()
//        }
//        
//        dispatchGroup.wait()
//        dispatchGroup.notify(queue: .main) {
//            print("all activities complete")
//        }
    }
}
