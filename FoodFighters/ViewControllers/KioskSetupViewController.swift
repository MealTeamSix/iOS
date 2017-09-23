//
//  KioskSetupViewController.swift
//  FoodFighters
//
//  Created by Corbin Rangler on 9/23/17.
//  Copyright © 2017 Yello. All rights reserved.
//

import UIKit

class KioskSetupViewController: UIViewController {
    
    let kioskSegueIdentifier = "KioskSegue"
    
    @IBOutlet weak var textView: UITextView! {
        didSet {
            textView.delegate = self
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let vc = segue.destination as? ClientDataCollectionViewController {
            vc.kioskZipCode = textView.text ?? ""
        }
    }
    
    @IBAction func enterKiosk() {
        performSegue(withIdentifier: kioskSegueIdentifier, sender: self)
    }
}

extension KioskSetupViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
