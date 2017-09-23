//
//  ClientDataCollectionViewController.swift
//  FoodFighters
//
//  Created by Corbin Rangler on 9/23/17.
//  Copyright © 2017 Yello. All rights reserved.
//

import UIKit
import Firebase

class ClientDataCollectionViewController: UIViewController {
    
    @IBOutlet weak var tableHandler: ClientDataCollectionTableHandler! {
        didSet {
            tableHandler.delegate = self
        }
    }
    
    var kioskZipCode = ""
    var userJsonToSubmit = [String: String]()
    var dbUserData: Any!
    let ref = Database.database().reference(withPath: "KioskSignIns")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userJsonToSubmit["kiosk_zip_code"] = kioskZipCode

        ref.observe(.value, with: { snapshot in
            self.dbUserData = snapshot.value
        })

    }
    
    @IBAction func submit() {
        let userRef = ref.child(UUID().uuidString)
        userRef.setValue(userJsonToSubmit)
        
        print("👽ayyyyyyyyylmao👽")
        print("total users: \((dbUserData! as AnyObject).count! + 1)")
        
        let alert = UIAlertController(title: "Success", message: "🎉", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { _ in
            self.tableHandler.reset()
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)

        tableHandler.reset()
    }
}

extension ClientDataCollectionViewController: ClientDataCollectionPartialUpdatedDelegate {
    
    func didUpdate(_ dataPartial: ClientDataCollectionPartial, withText text: String) {
        userJsonToSubmit[dataPartial.rawValue] = text
    }
}
