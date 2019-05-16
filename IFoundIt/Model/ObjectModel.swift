//
//  ObjectModel.swift
//  IFoundIt
//
//  Created by AMIMOBILE on 03/04/2019.
//  Copyright © 2019 lehuong. All rights reserved.
//

import Foundation

struct ObjectModel {
    
    var objectCodePostal: String?
    var objectDate: String?
    var objectDescription: String?
    var objectName: String?
    var objectImageUrl: String?
    
    // Inits
    init(objectCodePostal: String, objectDate: String, objectDescription: String, objectName: String, objectImageUrl: String) {
        self.objectCodePostal = objectCodePostal
        self.objectDate = objectDate
        self.objectDescription = objectDescription
        self.objectName = objectName
        self.objectImageUrl = objectImageUrl
    }
}
