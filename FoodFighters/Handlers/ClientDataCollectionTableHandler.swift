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
            
            tableView.rowHeight = UITableViewAutomaticDimension
            tableView.estimatedRowHeight = 117
            
            tableView.contentInset.top = 135
            
            let nib = UINib(nibName: cellIdentifier, bundle: Bundle.main)
            tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
        }
    }
    
    weak var delegate: ClientDataCollectionPartialUpdatedDelegate!
    var dataSource: [ClientDataCollectionPartial] = [.email, .phone, .userZipCode]
    
    func reset() {
        tableView.reloadData()
    }
}

extension ClientDataCollectionTableHandler: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let nibs = Bundle.main.loadNibNamed("ClientDataCollectionTableHeaderView", owner: nil, options: nil)
        return nibs!.first as! ClientDataCollectionTableHeaderView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
}

extension ClientDataCollectionTableHandler: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let partial = dataSource[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! ClientDataCollectionTableViewCell
        cell.configure(withPartial: partial)
        cell.delegate = self
        
        return cell
    }
}

extension ClientDataCollectionTableHandler: ClientDataCollectionPartialUpdatedDelegate {
    
    func didUpdate(_ dataPartial: ClientDataCollectionPartial, withText text: String) {
        delegate.didUpdate(dataPartial, withText: text)
    }
}
