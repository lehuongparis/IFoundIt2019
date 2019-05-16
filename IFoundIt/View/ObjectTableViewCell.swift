//
//  ObjectTableViewCell.swift
//  IFoundIt
//
//  Created by AMIMOBILE on 03/04/2019.
//  Copyright © 2019 lehuong. All rights reserved.
//

import UIKit

class ObjectTableViewCell: UITableViewCell {

    @IBOutlet weak var objectImageView: UIImageView!
    @IBOutlet weak var objectNameLabel: UILabel!
    @IBOutlet weak var objectDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configure(objectName: String, objectDate: String, objectImage: UIImage) {
        objectNameLabel.text = objectName
        objectDateLabel.text = objectDate
        objectImageView.image = objectImage
    }
}
