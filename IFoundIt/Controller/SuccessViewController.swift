//
//  SuccessViewController.swift
//  IFoundIt
//
//  Created by AMIMOBILE on 29/03/2019.
//  Copyright © 2019 lehuong. All rights reserved.
//

import UIKit
import FirebaseAuth

class SuccessViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    // MARK: Actions
    @IBAction func signOutButton() {
        signOut()
    }
    
    // Sign Out of Firebase
    private func signOut() {
        do {
            try Auth.auth().signOut()
        } catch  {
            print("can't log out")
        }
    }
}
