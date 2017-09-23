//
//  ClientDataCollectionPartialUpdatedDelegate.swift
//  FoodFighters
//
//  Created by Corbin Rangler on 9/23/17.
//  Copyright © 2017 Yello. All rights reserved.
//

enum ClientDataCollectionPartial: String {
    case email
    case phone
    case zipcode
}

protocol ClientDataCollectionPartialUpdatedDelegate: class {
    func didUpdate(_ dataPartial: ClientDataCollectionPartial, withText text: String)
}
