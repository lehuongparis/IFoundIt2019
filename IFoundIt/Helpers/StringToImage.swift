//
//  StringToImage.swift
//  IFoundIt
//
//  Created by AMIMOBILE on 06/05/2019.
//  Copyright © 2019 lehuong. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    var stringToImage: UIImage? {
        
        get {
            let url = URL(string: self)
            if let data = try? Data(contentsOf: url!) {
                return UIImage(data: data)
            } else {
                return UIImage(named: "object.jpg")
            }
        }
    }
}


