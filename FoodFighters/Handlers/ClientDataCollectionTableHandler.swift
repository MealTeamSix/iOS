//
//  ClientDataCollectionTableHandler.swift
//  FoodFighters
//
//  Created by Corbin Rangler on 9/23/17.
//  Copyright © 2017 Yello. All rights reserved.
//

import Foundation
import UIKit

class ClientDataCollectionTableHandler: NSObject {
    
    let cellIdentifier = "ClientDataCollectionTableViewCell"
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            let nib = UINib(nibName: cellIdentifier, bundle: Bundle.main)
            tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
        }
    }
    
    weak var delegate: ClientDataCollectionPartialUpdatedDelegate!
    var dataSource: [ClientDataCollectionPartial] = [.email, .phone, .zipcode]
}

extension ClientDataCollectionTableHandler: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let partial = dataSource[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! ClientDataCollectionTableViewCell
        cell.configure(withPartial: partial)
        return cell
    }
}

extension ClientDataCollectionTableHandler: ClientDataCollectionPartialUpdatedDelegate {
    
    func didUpdate(_ dataPartial: ClientDataCollectionPartial, withText text: String) {
        delegate.didUpdate(dataPartial, withText: text)
    }
}
