//
//  DateMeTests.swift
//  DateMeTests
//
//  Created by Sterling Mortensen on 5/16/17.
//  Copyright © 2017 Sterling Mortensen. All rights reserved.
//

import XCTest
import Foundation
import CloudKit
@testable import DateMe
class DateMeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

class GenerateTableView: XCTestCase {
    static let shared = GenerateTableView()
    
    func testCreatMocUsers() {
        let ID = CKRecordID(recordName: "User")
        let ref = CKReference(recordID: ID, action: .none)
        let mocUsers: [User] = [
            User(firstName: "John", lastName: "Dart", age: 45, email: "example@dave.com", gender: "male", chats: [], profileImageData: Data(), appleDefaultUserRef: ref), User(firstName: "Sterling", lastName: "Tickit", age: 23, email: "example@da3ve.com", gender: "female", chats: [], profileImageData: Data(), appleDefaultUserRef: ref), User(firstName: "Black", lastName: "Sarah", age: 33, email: "example@dave.com", gender: "male", chats: [], profileImageData: Data(), appleDefaultUserRef: ref), User(firstName: "Genny", lastName: "Gustin", age: 12, email: "example@dave.com", gender: "Female", chats: [], profileImageData: Data(), appleDefaultUserRef: ref), User(firstName: "Sam", lastName: "Ward", age: 25, email: "example@dave.com", gender: "Female", chats: [], profileImageData: Data(), appleDefaultUserRef: ref)
        ]
    }
    
    
    
    
}
