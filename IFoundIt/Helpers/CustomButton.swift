//
//  CustomButton.swift
//  IFoundIt
//
//  Created by AMIMOBILE on 26/03/2019.
//  Copyright © 2019 lehuong. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        self.backgroundColor = UIColor(red: 0.7765, green: 0.1529, blue: 0, alpha: 1.0)
        self.layer.cornerRadius = 20
        self.setTitleColor(UIColor.white, for: .normal)
        
    }
}
