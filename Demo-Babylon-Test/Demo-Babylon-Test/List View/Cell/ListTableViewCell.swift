//
//  ListTableViewCell.swift
//  Demo-Babylon-Test
//
//  Created by Antoine Simon on 05/10/2019.
//  Copyright © 2019 antoine simon. All rights reserved.
//

import UIKit

protocol ListTableViewCellProtocol {
    func setNameLabel(name: String)
    func setQuantityLabel(quantity: String)
    func editButton(title: String)
    func deleteButton(title: String)
}

class ListTableViewCell: UITableViewCell {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var quantity: UILabel!
    @IBOutlet private weak var editButton: UIButton!
    @IBOutlet private weak var deleteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}

extension ListTableViewCell: ListTableViewCellProtocol {
    
}
