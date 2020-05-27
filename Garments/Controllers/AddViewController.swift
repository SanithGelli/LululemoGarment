//
//  AddViewController.swift
//  Garments
//
//  Created by Sanith on 5/26/20.
//  Copyright © 2020 Sanith. All rights reserved.
//

import UIKit
import CoreData

protocol AddViewControllerDelegate: NSObjectProtocol {
    func saveGarments()
}

class AddViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var enterGarment: UITextField!
    
    weak var delegate: AddViewControllerDelegate?
    
    //MARK:- Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.enterGarment.delegate = self
        self.saveButtonEnable()
    }
    
    //MARK: Action Methods
    @IBAction func saveAction(_ sender: Any) {
        let name = enterGarment.text!
        let garment = Garment(context: PersistanceService.context)
        garment.name = name
        garment.date = Date()
        
        PersistanceService.saveContext()
        delegate?.saveGarments()
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func textFieldsIsNotEmpty(sender: UITextField) {
        sender.text = sender.text?.trimmingCharacters(in: .whitespaces)
        guard
            let name = enterGarment.text, !name.isEmpty
            else
        {
            self.saveButton.isEnabled = false
            return
        }
        saveButton.isEnabled = true
    }
    
    //MARK: Helper Mehtods
    func saveButtonEnable() {
        saveButton.isEnabled = false //hidden okButton
        enterGarment.addTarget(self, action: #selector(textFieldsIsNotEmpty),
                               for: .editingChanged)
    }
    
    //MARK: - TextField Delegate Methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.enterGarment.resignFirstResponder()
        return true
    }
}
