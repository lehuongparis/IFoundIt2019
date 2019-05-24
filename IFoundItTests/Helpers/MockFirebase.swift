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
        let snapShot = MockDataSnapShot()
        block(snapShot)
    }
    
    override func setValue(_ value: Any?) {
        self.database.reference().setValue(value)
        print(value)
        print("test45")
    }
}

private class MockDataSnapShot: DataSnapshot {
    override var value: Any? {
        print("test46")
        return ["objectImageUrl": "www.google.com", "objectcodepostal": "75013", "objectdate": "100519", "objectdescription": "c'est un objet perdu", "objectname:": "Samsung S1"]
    }
}



