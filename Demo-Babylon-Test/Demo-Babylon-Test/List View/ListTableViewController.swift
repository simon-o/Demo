//
//  ListTableViewController.swift
//  Demo-Babylon-Test
//
//  Created by Antoine Simon on 02/10/2019.
//  Copyright © 2019 antoine simon. All rights reserved.
//

import UIKit

protocol ListTableViewControllerProtocol: AnyObject {
    func reload()
}

final class ListTableViewController: UITableViewController {
    private let presenter: ListPresenterProtocol
    
    init(presenter: ListPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: String(describing: ListTableViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

     
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
}

extension ListTableViewController: ListTableViewControllerProtocol {
    func reload() {
        // MARK: - reload tableView
    }
}
