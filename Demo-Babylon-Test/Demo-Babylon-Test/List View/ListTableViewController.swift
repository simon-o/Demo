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
    func setNavigationTitle(_ title: String)
    func setNavigationItem()
    
    func goToAddView()
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

        presenter.attachView(view: self)
        presenter.viewDidLoad()
     
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
    
    @objc func addClicked() {
        presenter.addClicked()
    }
}

extension ListTableViewController: ListTableViewControllerProtocol {
    func goToAddView() {
        let presenter = AddItemPresenter(fireBase: FirebaseManager())
        let viewController = AddItemViewController(presenter: presenter)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func setNavigationTitle(_ title: String) {
        navigationItem.title = title
    }
    
    func setNavigationItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addClicked))
    }
    
    func setNavigationItemCouner() {
        //TODO: Need to be done with RXSwift to learn
    }
    
    func reload() {
        tableView.reloadData()
    }
}
