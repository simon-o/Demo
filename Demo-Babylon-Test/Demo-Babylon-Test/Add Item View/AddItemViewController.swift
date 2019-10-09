//
//  AddItemViewController.swift
//  Demo-Babylon-Test
//
//  Created by Antoine Simon on 03/10/2019.
//  Copyright © 2019 antoine simon. All rights reserved.
//

import UIKit

protocol AddItemViewControllerProtocol: BaseViewControllerProtocol {
    func setNavigationItem()
    func setNameTextfieldPlaceholder(text: String)
    func setQuantityTextfieldPlaceholder(text: String)
    func setNameTextfieldText(text: String)
    func setQuantityTextfield(text: String)
    func setButtonTitle(title: String)
    
    func getNameTextfield() -> String
    func getQuantityTextfield() -> String
    
    func goToOCR()
    func goBack()
}

class AddItemViewController: UIViewController {

    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var itemNameTextField: UITextField!
    @IBOutlet private weak var quantityTextField: UITextField!
    @IBOutlet weak var ocrButton: UIButton!
    
    private let presenter: AddItemPresenterProtocol
    
    init(presenter: AddItemPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: String(describing: AddItemViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)

        presenter.attachView(self)
        presenter.viewDidLoad()
    }
    
    @objc func keyboardWillShow(notification:NSNotification){

        let userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)

        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        scrollView.contentInset = contentInset
    }

    @objc func keyboardWillHide(notification:NSNotification){

        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
    
    @objc func saveClicked() {
        presenter.saveClicked()
    }
    @IBAction func ocrButtonClicked(_ sender: Any) {
        presenter.buttonCLicked()
    }
}

extension AddItemViewController: AddItemViewControllerProtocol {
    func goToOCR() {
        let presenter = OCRPresenter(delegate: self)
        let viewController = OCRViewController(presenter: presenter)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func setButtonTitle(title: String) {
        ocrButton.setTitle(title, for: .normal)
    }
    
    func setNameTextfieldText(text: String) {
        itemNameTextField.text = text
    }
    
    func setQuantityTextfield(text: String) {
        quantityTextField.text = text
    }
    
    func goBack() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func setNameTextfieldPlaceholder(text: String) {
        itemNameTextField.placeholder = text
    }
    
    func setQuantityTextfieldPlaceholder(text: String) {
        quantityTextField.placeholder = text
    }
    
    func getNameTextfield() -> String {
        return itemNameTextField.text ?? ""
    }
    
    func getQuantityTextfield() -> String {
        return quantityTextField.text ?? ""
    }
    
    func setNavigationItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveClicked))
    }
}

extension AddItemViewController: OCRPresenterDelegate {
    func fillWith(name: String) {
        
    }
}
