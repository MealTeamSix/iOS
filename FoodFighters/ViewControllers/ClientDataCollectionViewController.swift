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
    
    @IBOutlet weak var constraintToAdjust: NSLayoutConstraint!
    
    var kioskZipCode = ""
    var userJsonToSubmit = [String: String]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        userJsonToSubmit["kiosk_zip_code"] = kioskZipCode
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
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
    
    @IBAction func exit() {
        navigationController!.popViewController(animated: true)
    }
    
    func keyboardWillShow(_ notification: Notification) {
        
        let userInfo = notification.userInfo!
        let keyboardRectValue = userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue
        let keyboardRect = keyboardRectValue.cgRectValue
        let adjustedKeyboardRect = view.convert(keyboardRect, from: nil)
        
        constraintToAdjust.constant = view.frame.height - adjustedKeyboardRect.origin.y
        
        let animationDuration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! Double
        UIView.animate(withDuration: animationDuration, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    func keyboardWillHide(_ notification: Notification) {
        
        constraintToAdjust.constant = 0
        let userInfo = notification.userInfo!
        let animationDuration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! Double
        
        UIView.animate(withDuration: animationDuration, animations: {
            self.view.layoutIfNeeded()
        })
    }
}

extension ClientDataCollectionViewController: ClientDataCollectionPartialUpdatedDelegate {
    
    func didUpdate(_ dataPartial: ClientDataCollectionPartial, withText text: String) {
        userJsonToSubmit[dataPartial.rawValue] = text
    }
}
