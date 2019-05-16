//
//  ObjectDetailViewController.swift
//  IFoundIt
//
//  Created by AMIMOBILE on 19/04/2019.
//  Copyright © 2019 lehuong. All rights reserved.
//

import UIKit

class ObjectDetailViewController: UIViewController {

    // MARK: - Vars, Lets
    var objectDetail: ObjectModel?

    @IBOutlet weak var objectNameLabel: UILabel!
    @IBOutlet weak var objectDateLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var objectDescriptionLabel: UILabel!
    
    @IBOutlet weak var objectImageLabel: UILabel!
    @IBOutlet weak var objectImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateObjectDetail()
    }
    
    // Update Info for Object Detail
    func updateObjectDetail() {
        objectNameLabel.text = objectDetail?.objectName
        objectDateLabel.text = objectDetail?.objectDate
        objectDescriptionLabel.text = objectDetail?.objectDescription
        objectImageView.image = objectDetail?.objectImageUrl?.stringToImage
        }
    }


