//
//  CustomLabel.swift
//  IFoundIt
//
//  Created by AMIMOBILE on 09/05/2019.
//  Copyright © 2019 lehuong. All rights reserved.
//

import Foundation
import UIKit

class CustomLabel: UILabel {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {

        self.backgroundColor = UIColor(red:0.18, green:0.55, blue:0.39, alpha:1.0)
        self.layer.cornerRadius = 20
    }
}
