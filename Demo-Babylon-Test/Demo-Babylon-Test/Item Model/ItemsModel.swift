//
//  ItemsModel.swift
//  Demo-Babylon-Test
//
//  Created by Antoine Simon on 06/10/2019.
//  Copyright © 2019 antoine simon. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct ItemList: Codable {
    var name: String
    var quantity: String
    var key: String
}

final class Parser {
    func parseItemList(snapshot: DataSnapshot) -> [ItemList] {
        let value = snapshot.value as? NSDictionary
        let keys = value?.allKeys
        
        var itemsList: [ItemList] = []
        keys?.forEach({ (key) in
            let item = value?[key] as? [String: String]
            itemsList.append(ItemList(name: (item?["name"])!, quantity: (item?["quantity"])!, key: key as! String))
        })
        return itemsList
    }
}

