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
    func setNavigationItemCounter()
    
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

        tableView.register(UINib.init(nibName: String(describing: ListTableViewCell.self), bundle: nil), forCellReuseIdentifier: "ListTableViewCell")
            
        presenter.attachView(view: self)
        presenter.viewDidLoad()
     
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.getNumberSection()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getNumberRow(for: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell:ListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as? ListTableViewCell {
            presenter.buildCell(cell: cell, index: indexPath)
             return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75.0
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
    
    func setNavigationItemCounter() {
        //TODO: Need to be done with RXSwift to learn
    }
    
    func reload() {
        tableView.reloadData()
    }
}
