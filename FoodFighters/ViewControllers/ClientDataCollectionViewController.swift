//
//  ClientDataCollectionViewController.swift
//  FoodFighters
//
//  Created by Corbin Rangler on 9/23/17.
//  Copyright © 2017 Yello. All rights reserved.
//

import UIKit

class ClientDataCollectionViewController: UIViewController {
    
    @IBOutlet weak var tableHandler: ClientDataCollectionTableHandler! {
        didSet {
            tableHandler.delegate = self
        }
    }
    
    var kioskZipCode = ""
    var userJsonToSubmit = [String: String]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        userJsonToSubmit["kiosk_zip_code"] = kioskZipCode
    }
    
    @IBAction func submit() {
        
        //submit the userJsonToSubmit to Firebase! 🎉
        let alert = UIAlertController(title: "Success", message: "🎉", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { _ in
            self.tableHandler.reset()
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
}

extension ClientDataCollectionViewController: ClientDataCollectionPartialUpdatedDelegate {
    
    func didUpdate(_ dataPartial: ClientDataCollectionPartial, withText text: String) {
        userJsonToSubmit[dataPartial.rawValue] = text
    }
}
