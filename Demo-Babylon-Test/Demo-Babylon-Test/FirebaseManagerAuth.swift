//
//  FirebaseManagerAuth.swift
//  Demo-Babylon-Test
//
//  Created by Antoine Simon on 29/09/2019.
//  Copyright © 2019 antoine simon. All rights reserved.
//

import Foundation
import FirebaseAuth

protocol FirebaseManagerAuthProtocol: AnyObject {
    func createUser(email: String, password: String, completionBlock: @escaping (Bool, String?) -> Void)
}
class FirebaseManagerAuth: FirebaseManagerAuthProtocol{
    func createUser(email: String, password: String, completionBlock: @escaping (Bool, String?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) {(authResult, error) in
            if let _ = authResult?.user {
                completionBlock(true, nil)
            } else {
                completionBlock(false, error?.localizedDescription)
            }
        }
    }
}
