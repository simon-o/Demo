//
//  FireBaseManager.swift
//  Demo-Babylon-Test
//
//  Created by Antoine Simon on 29/09/2019.
//  Copyright © 2019 antoine simon. All rights reserved.
//

import Foundation
import FirebaseAuth

class FirebaseAuthManager {
    func createUser(email: String, password: String, completionBlock: @escaping (_ success: Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) {(authResult, error) in
            if let user = authResult?.user {
                print(user)
                completionBlock(true)
            } else {
                completionBlock(false)
            }
        }
    }
}
