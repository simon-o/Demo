 //
//  ForgottenPasswordViewController.swift
//  Demo-Babylon-Test
//
//  Created by Antoine Simon on 02/10/2019.
//  Copyright © 2019 antoine simon. All rights reserved.
//

import UIKit
 
 protocol ForgottenPasswordViewControllerProtocol: BaseViewControllerProtocol {
    func goBack()
    
    func setEmailPlaceHolder(_ placeHolder: String)
    func setButtonTitle(_ title: String)
    func getEmailTextField() -> String?
 }

final class ForgottenPasswordViewController: UIViewController {

    
    @IBOutlet private weak var sendButton: UIButton!
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var emailTextField: UITextField!
    
    private let presenter: ForgottenPasswordPresenterProtocol
    
    init(presenter: ForgottenPasswordPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: String(describing: ForgottenPasswordViewController.self), bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.attachView(self)
        presenter.viewDidLoad()
    }
    
    @IBAction func sendButtonClicked(_ sender: Any) {
        presenter.sendButtonClicked()
    }
 }

 extension ForgottenPasswordViewController: ForgottenPasswordViewControllerProtocol {
    func getEmailTextField() -> String? {
        return emailTextField.text
    }
    
    func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    func setEmailPlaceHolder(_ placeHolder: String) {
        emailTextField.placeholder = placeHolder
    }
    
    func setButtonTitle(_ title: String) {
        sendButton.setTitle(title, for: .normal)
    }
 }
