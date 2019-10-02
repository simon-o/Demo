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
    func signOut(completionBlock: @escaping (Bool, Error?) -> Void)
    func forgottenPassword(email: String, completionBlock: @escaping (Error?) -> Void)
}

final class FirebaseManagerAuth: FirebaseManagerAuthProtocol{
    func createUser(email: String, password: String, completionBlock: @escaping (Bool, String?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) {(authResult, error) in
            if let _ = authResult?.user {
                completionBlock(true, nil)
            } else {
                completionBlock(false, error?.localizedDescription)
            }
        }
    }
    
    func authentication(email: String, password: String, completionBlock: @escaping (Bool, String?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error, let _ = AuthErrorCode(rawValue: error._code) {
                completionBlock(false, error.localizedDescription)
            } else {
                completionBlock(true, nil)
            }
        }
    }
    
    func signOut(completionBlock: @escaping (Bool, Error?) -> Void) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            completionBlock(true, nil)
        } catch let signOutError {
            completionBlock(false, signOutError)
        }
    }
    
    func forgottenPassword(email: String, completionBlock: @escaping (Error?) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            completionBlock(error)
        }
    }
}
