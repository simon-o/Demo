//
//  AsyncViewController.swift
//  Demo-Babylon-Test
//
//  Created by Antoine Simon on 11/10/2019.
//  Copyright © 2019 antoine simon. All rights reserved.
//

import UIKit

protocol AsyncViewControllerProtocol: AnyObject {
    func setButton(title: String)
    func setSecondButton(title: String)
    func addTextView(text: String)
    func clearText()
}

class AsyncViewController: UIViewController {
    private var presenter: AsyncPresenterProtocol
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    
    init(presenter: AsyncPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: String(describing: AsyncViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewAttach(view: self)
        presenter.viewDidLoad()
    }
    
    @IBAction func buttonClicked(_ sender: Any) {
        presenter.buttonClicked()
    }
    
    @IBAction func secondButtonClicked(_ sender: Any) {
        presenter.secondButtonClicked()
    }
}

extension AsyncViewController: AsyncViewControllerProtocol {
    func addTextView(text: String) {
        textView.text = (textView.text) + " " + (text)
    }
    
    func clearText() {
        textView.text = ""
    }
    
    func setSecondButton(title: String) {
        secondButton.setTitle(title, for: .normal)
    }
    
    func setButton(title: String) {
        button.setTitle(title, for: .normal)
    }
}
