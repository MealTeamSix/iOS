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
    @IBOutlet weak var textField: UITextField! {
        didSet {
            textField.delegate = self
        }
    }
    
    weak var delegate: ClientDataCollectionPartialUpdatedDelegate!
    var clientDataCollectionPartial: ClientDataCollectionPartial!
    
    func configure(withPartial partial: ClientDataCollectionPartial) {
        clientDataCollectionPartial = partial
        dataPartialLabel.text = partial.rawValue
    }
}

extension ClientDataCollectionTableViewCell: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate.didUpdate(clientDataCollectionPartial, withText: textField.text ?? "")
    }
}
