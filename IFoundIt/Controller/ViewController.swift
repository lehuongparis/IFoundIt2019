//
//  ViewController.swift
//  IFoundIt
//
//  Created by AMIMOBILE on 23/03/2019.
//  Copyright © 2019 lehuong. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage
 
class ViewController: UIViewController {

    // MARK: - Vars, Lets
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var objectDataList = [String: AnyObject]()
    private let objectService = ObjectService(databaseRef: Database.database().reference(), storageRef: Storage.storage().reference())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true
    }
    
    // MARK: - Methods
    
    // Unwind to ViewController
    @IBAction func unwindtoHome(segue: UIStoryboardSegue) { }

    // Segue to Inscription
    @IBAction func inscriptionButton() {
        performSegue(withIdentifier: "segueToInscription", sender: self)
    }
    
    // Search objects and segue to Search Page
    @IBAction func searchButton() {
        activityIndicator.isHidden = false
        listAllObjects()
    }
    
    // Segue to Info Page
    @IBAction func infoButton() {
        performSegue(withIdentifier: "segueToInfo", sender: self)
    }
  
    // Fetch all Objects
   private func listAllObjects() {
    objectService.fetchAllObject { (snapShot) in
        guard let postDict = snapShot.value as? [String: AnyObject] else { return }
            self.objectDataList = postDict
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "segueToSearch", sender: self)
                self.activityIndicator.isHidden = true
            }
        }
    }
    
    // Prepare Segue to Search View
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToSearch" {
            let searchVC = segue.destination as! SearchViewController
            searchVC.objectDataList = objectDataList
            }
        }
    }




