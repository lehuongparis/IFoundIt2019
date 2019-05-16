//
//  ObjectServiec.swift
//  IFoundIt
//
//  Created by AMIMOBILE on 03/05/2019.
//  Copyright © 2019 lehuong. All rights reserved.
//

import Foundation
import Firebase

class ObjectService {
    
    // MARK: - Vars, Lets
    private let databaseRef: DatabaseReference
    private let storageRef: StorageReference
    
    // MARK: - Init
    init(databaseRef: DatabaseReference, storageRef: StorageReference) {
        self.databaseRef = databaseRef
        self.storageRef = storageRef
    }
    
    // MARK: - Methods
    
    // Save Objet into Database/Firebase
    func saveObject(objectName: String, objectCodePostal: String, objectDate: String, objectDescription: String, objectImageView: UIImageView) {
        
        let objectRefs = databaseRef.childByAutoId()
        guard let key = objectRefs.key else { return }
        let objectImageRef = storageRef.child(key)
        
        // Upload Object Image to Storage
        if let imageData = objectImageView.image?.jpegData(compressionQuality: 0.7) {
            objectImageRef.putData(imageData, metadata: nil) { (metadata, error) in
                if let error = error {
                    print(error)
                    return
                }
                // load URL for Object Image
                objectImageRef.downloadURL { (url, error) in
                    if let error = error {
                        print(error)
                        return }
                    
                    if let objectImageUrl = url?.absoluteString {
                        self.setupObject(objectRefs: objectRefs, objectName: objectName, objectCodePostal: objectCodePostal, objectDate: objectDate, objectDescription: objectDescription, objectImageUrl: objectImageUrl)
                    }
                }
            }
        }
    }
    
    // Setup Value for a object before saving in Database
    private func setupObject(objectRefs: DatabaseReference, objectName: String, objectCodePostal: String, objectDate: String, objectDescription: String, objectImageUrl: String) {
        if objectName != "" && objectCodePostal != "" && objectDate != "" && objectDescription != "" {
            let objet = ["objectname": objectName, "objectcodepostal": objectCodePostal, "objectdate": objectDate, "objectdescription": objectDescription, "objectImageUrl": objectImageUrl]
            objectRefs.setValue(objet)
        }
    }
    
    // Fetch All Object from Firebase
    func fetchAllObject(completionHandler: @escaping(DataSnapshot) -> Void) {
        databaseRef.observeSingleEvent(of: DataEventType.value) { (snapshot) in
            completionHandler(snapshot)
        }
    }
}
