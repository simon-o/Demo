//
//  ListTableViewCell.swift
//  Demo-Babylon-Test
//
//  Created by Antoine Simon on 05/10/2019.
//  Copyright © 2019 antoine simon. All rights reserved.
//

import UIKit

protocol ListTableViewCellProtocol: AnyObject {
    func setNameLabel(name: String)
    func setQuantityLabel(quantity: String)
    func editButton(title: String)
    func deleteButton(title: String)
    
    func setActionEdit(completion: @escaping (() -> Void))
    func setActionDelete(completion: @escaping (() -> Void))
}

class ListTableViewCell: UITableViewCell {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var quantityLabel: UILabel!
    @IBOutlet private weak var editButton: UIButton!
    @IBOutlet private weak var deleteButton: UIButton!
    
    var actionEdit: (() -> Void)?
    var actionDelete: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    @IBAction func editButtonClicked(_ sender: Any) {
        guard let action = actionEdit else { return }
        action()
    }
    
    @IBAction func deleteButtonClicked(_ sender: Any) {
        guard let action = actionDelete else { return }
        action()
    }
}

extension ListTableViewCell: ListTableViewCellProtocol {
    func setActionEdit(completion: @escaping (() -> Void)) {
        self.actionEdit = completion
    }
    
    func setActionDelete(completion: @escaping (() -> Void)) {
        self.actionDelete = completion
    }
    
    func setNameLabel(name: String) {
        nameLabel.text = name
    }
    
    func setQuantityLabel(quantity: String) {
        quantityLabel.text = quantity
    }
    
    func editButton(title: String) {
        editButton.setTitle(title, for: .normal)
    }
    
    func deleteButton(title: String) {
        deleteButton.setTitle(title, for: .normal)
    }
}
