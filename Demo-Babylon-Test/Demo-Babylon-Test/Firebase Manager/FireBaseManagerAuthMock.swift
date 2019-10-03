//
//  FireBaseManagerAuthMock.swift
//  Demo-Babylon-TestTests
//
//  Created by Antoine Simon on 03/10/2019.
//  Copyright © 2019 antoine simon. All rights reserved.
//

import XCTest
@testable import Demo_Babylon_Test

class FirebaseManagerAuthMock {
    var booleanReturn: Bool?
    var stringErrorReturn: String?
    var errorReturn: Error?     
}

extension FirebaseManagerAuthMock: FirebaseManagerAuthProtocol {
    func authentication(email: String, password: String, completionBlock: @escaping (Bool, String?) -> Void)  {
        completionBlock(booleanReturn!, stringErrorReturn)
    }
    
    func createUser(email: String, password: String, completionBlock: @escaping (Bool, String?) -> Void) {
        completionBlock(booleanReturn!, stringErrorReturn)
    }
    
    func signOut(completionBlock: @escaping (Bool, Error?) -> Void) {
        completionBlock(booleanReturn!, errorReturn)
    }
    
    func forgottenPassword(email: String, completionBlock: @escaping (Error?) -> Void) {
        completionBlock(errorReturn)
    }
}
