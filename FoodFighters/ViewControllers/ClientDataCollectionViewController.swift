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
    
    var userJsonToSubmit = [String: String]()
    
    @IBAction func submit() {
        //submit the userJsonToSubmit to Firebase! 🎉
    }
}

extension ClientDataCollectionViewController: ClientDataCollectionPartialUpdatedDelegate {
    
    func didUpdate(_ dataPartial: ClientDataCollectionPartial, withText text: String) {
        userJsonToSubmit[dataPartial.rawValue] = text
    }
}