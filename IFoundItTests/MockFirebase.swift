//
//  MockFirebase.swift
//  IFoundItTests
//
//  Created by AMIMOBILE on 09/05/2019.
//  Copyright © 2019 lehuong. All rights reserved.
//

import Foundation
import Firebase

class MockDatabaseReference: DatabaseReference {
    
    override func child(_ pathString: String) -> DatabaseReference {
        return self
    }
    
    override func observeSingleEvent(of eventType: DataEventType, with block: @escaping (DataSnapshot) -> Void) {
        let snapshot = MockDataSnapShot()
        block(snapshot)
    }
}




class MockStorageReference: StorageReference {

    var error: Error?
    
    override func child(_ path: String) -> StorageReference {
        return self
    }
    
//    override func putData(_ uploadData: Data, metadata: StorageMetadata?, completion: ((StorageMetadata?, Error?) -> Void)? = nil) -> StorageUploadTask {
//        let metadata = MockStorageMetadata()
//        completion(metadata, Error?)
//    }
    
    override func downloadURL(completion: @escaping (URL?, Error?) -> Void) {
        let url = URL(fileURLWithPath: "www.google.com")
        completion(url, error)
    }
        
}


private class MockStorageMetadata: StorageMetadata {
    

}


private class MockDataSnapShot: DataSnapshot {
    override var value: Any? {
        return ["objectID": "12345", "objectImageUrl": "www.google.com", "objectcodepostal": "75013", "objectdate": "100519", "objectdescription": "c'est un objet perdu", "objectname:": "Samsung S1"]
    }
}



