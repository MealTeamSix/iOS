//
//  ClientDataCollectionTableViewCell.swift
//  FoodFighters
//
//  Created by Corbin Rangler on 9/23/17.
//  Copyright © 2017 Yello. All rights reserved.
//

import UIKit

class ClientDataCollectionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dataPartialLabel: UILabel!
    @IBOutlet weak var textView: UITextView! {
        didSet {
            textView.delegate = self
        }
    }
    
    weak var delegate: ClientDataCollectionPartialUpdatedDelegate!
    var clientDataCollectionPartial: ClientDataCollectionPartial!
    
    func configure(withPartial partial: ClientDataCollectionPartial) {
        clientDataCollectionPartial = partial
        dataPartialLabel.text = partial.displayText
        textView.text = ""
    }
}

extension ClientDataCollectionTableViewCell: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        delegate.didUpdate(clientDataCollectionPartial, withText: textView.text ?? "")
    }
}
