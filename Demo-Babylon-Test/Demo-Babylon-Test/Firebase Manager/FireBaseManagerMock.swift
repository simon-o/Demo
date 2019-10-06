//
//  FireBaseManagerMock.swift
//  Demo-Babylon-Test
//
//  Created by Antoine Simon on 06/10/2019.
//  Copyright © 2019 antoine simon. All rights reserved.
//

import XCTest
import FirebaseDatabase
@testable import Demo_Babylon_Test

class FirebaseManagerMock {
    var dataReferenceReturn: DatabaseReference!
    var errorReturn: Error?
    var listReturn: [ItemList]!
}

extension FirebaseManagerMock: FirebaseManagerProtocol {
    func addValue(name: String, quantity: String, completion: @escaping ((Error?, DatabaseReference) -> Void)) {
        completion(errorReturn, dataReferenceReturn)
    }
    
    func removeValue(id: String, completion: @escaping ((Error?, DatabaseReference) -> Void)) {
        completion(errorReturn, dataReferenceReturn)
    }
    
    func updateValue(id: String, name: String, quantity: String, completion: @escaping ((Error?, DatabaseReference) -> Void)) {
        completion(errorReturn, dataReferenceReturn)
    }
    
    func getListForUser(completion: @escaping (([ItemList]) -> Void)) {
        completion(listReturn)
    }
}
