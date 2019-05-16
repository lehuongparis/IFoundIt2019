//
//  ObjecServiceTests.swift
//  IFoundItTests
//
//  Created by AMIMOBILE on 09/05/2019.
//  Copyright © 2019 lehuong. All rights reserved.
//

import XCTest
import Firebase
@testable import IFoundIt


class ObjectServiceTests: XCTestCase {

    func testFetchAllObject() {
        let objectService = ObjectService(databaseRef: MockDatabaseReference(), storageRef: MockStorageReference())
        
        let expectation = XCTestExpectation(description: "Expect for Fetching All Objects")
        
        objectService.fetchAllObject { snapShot in
            
            let postDict = snapShot.value as? [String: String] ?? ["": ""]
            
            XCTAssertEqual(postDict, ["objectID": "12345", "objectImageUrl": "www.google.com", "objectcodepostal": "75013", "objectdate": "100519", "objectdescription": "c'est un objet perdu", "objectname:": "Samsung S1"])
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.5)
    }
    
    
    func testSaveObject() {
        let objectService = ObjectService(databaseRef: MockDatabaseReference(), storageRef: MockStorageReference())
        
        let expectation =  XCTestExpectation(description: "Expect for adding object")
        
        
        let objectImageView = UIImageView()
        objectService.saveObject(objectName: "Samsung S10", objectCodePostal: "75013", objectDate: "10/05/2019", objectDescription: "C'est un Samsung", objectImageView: objectImageView)
        
        objectService.fetchAllObject { snapShot in
            
            let postDict = snapShot.value as? [String: String] ?? ["": ""]
            XCTAssertEqual(postDict, ["objectID": "12345", "objectImageUrl": "www.google.com", "objectcodepostal": "75013", "objectdate": "100519", "objectdescription": "c'est un objet perdu", "objectname:": "Samsung S1"])
            expectation.fulfill()
            
        }
        wait(for: [expectation], timeout: 0.5)
        
        
    }
 
}
