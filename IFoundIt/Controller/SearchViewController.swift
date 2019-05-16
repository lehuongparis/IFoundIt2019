//
//  SearchViewController.swift
//  IFoundIt
//
//  Created by AMIMOBILE on 26/03/2019.
//  Copyright © 2019 lehuong. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage

class SearchViewController: UIViewController {

    // MARK: - Vars, Lets
    @IBOutlet weak var objectTableView: UITableView!
    var objectDetail: ObjectModel?
    var objectList = [ObjectModel]()
    var objectDataList = [String: AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        objectTableView.tableFooterView = UIView()
    }
}

// MARK: - Extension TableView
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.item < objectDataList.count else { fatalError("Index out of range") }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ObjectCell", for: indexPath) as? ObjectTableViewCell else { return UITableViewCell() }
        setUpObjectList(objectDataList: objectDataList)
        let object = objectList[indexPath.row]
        cell.configure(objectName: object.objectName ?? "AAAA", objectDate: object.objectDate ?? "BBBBB", objectImage: object.objectImageUrl?.stringToImage ?? UIImage(named: "object.jpg")!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        objectDetail = self.objectList[indexPath.row]
            self.performSegue(withIdentifier: "segueToDetail", sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    // Set up Object List from List Data Firebase
    private func setUpObjectList(objectDataList: [String: AnyObject]) {
        for object in objectDataList {
            let objectCodePostal = object.value["objectcodepostal"] as? String ?? ""
            let objectDate = object.value["objectdate"] as? String ?? ""
            let objectDescription = object.value["objectdescription"] as? String ?? ""
            let objectName = object.value["objectname"] as? String ?? ""
            let objectImageUrl = object.value["objectImageUrl"] as? String ?? ""
            let objectModel = ObjectModel(objectCodePostal: objectCodePostal, objectDate: objectDate, objectDescription: objectDescription, objectName: objectName, objectImageUrl: objectImageUrl)
            self.objectList.append(objectModel)
        }
    }
    
    // Prepare segue to Object Detail View
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToDetail" {
            let detailVC = segue.destination as! ObjectDetailViewController
            detailVC.objectDetail = objectDetail
        }
    }

}


    



