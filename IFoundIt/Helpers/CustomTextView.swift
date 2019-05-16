//
//  CustomTextView.swift
//  IFoundIt
//
//  Created by AMIMOBILE on 18/04/2019.
//  Copyright © 2019 lehuong. All rights reserved.
//

import UIKit

class CustomTextView: UITextView {
    required init?(coder aDecoder: NSCoder) {
        super .init(coder: aDecoder)
        textContainerInset = UIEdgeInsets(top: 8, left: 4, bottom: 8, right: 4)
        self.layer.cornerRadius = 20
    }
}
