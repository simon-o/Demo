//
//  FireBaseManager.swift
//  Demo-Babylon-Test
//
//  Created by Antoine Simon on 03/10/2019.
//  Copyright © 2019 antoine simon. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

protocol FirebaseManagerProtocol: AnyObject {
    func addValue(name: String, quantity: String, completion: @escaping ((Error?, DatabaseReference) -> Void))
    func removeValue(id: String, completion: @escaping ((Error?, DatabaseReference) -> Void))
    func updateValue(id: String, name: String, quantity: String, completion: @escaping ((Error?, DatabaseReference) -> Void))
}

final class FirebaseManager: FirebaseManagerProtocol{
  
    let userID = Auth.auth().currentUser?.uid
    var ref: DatabaseReference = Database.database().reference()
    
    func addValue(name: String, quantity: String, completion: @escaping ((Error?, DatabaseReference) -> Void)) {
        let entry: [String: Any] = ["name" : name,
                                    "quantity" : quantity]
        
        ref.child(userID!).childByAutoId().setValue(entry, withCompletionBlock: completion)
    }
    
    func removeValue(id: String, completion: @escaping ((Error?, DatabaseReference) -> Void)) {
        ref.child(userID!).child(id).removeValue(completionBlock: completion)
    }
    
    func updateValue(id: String, name: String, quantity: String, completion: @escaping ((Error?, DatabaseReference) -> Void)) {
        let entry: [String: Any] = ["name" : name,
                                    "quantity" : quantity]

        ref.child(userID!).child(id).updateChildValues(entry, withCompletionBlock: completion)
    }
}
