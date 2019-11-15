//
//  HelpViewController.swift
//  GeoFinder
//
//  Created by Fabien HOARAU on 11/14/19.
//  Copyright © 2019 Fabien HOARAU. All rights reserved.
//

import UIKit

class HelpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var reportsListButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self
        titleTextField.delegate = self
        
        cancelButton.setTitle(NSLocalizedString("cancelBtn", comment: "Help"), for: .normal)
        confirmButton.setTitle(NSLocalizedString("confirmBtn", comment: "Help"), for: .normal)
        reportsListButton.setTitle(NSLocalizedString("reportList", comment: "Help"), for: .normal)
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func cancelBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func confirmBtn(_ sender: Any) {
        if textField.text! == "" || titleTextField.text! == "" {
            let alertController = UIAlertController(title: nil, message:
                NSLocalizedString("mess1", comment: "Help"), preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        } else if textField.text!.count <= 4 || titleTextField.text!.count <= 4 {
            let alertController = UIAlertController(title: nil, message:
                NSLocalizedString("mess2", comment: "Help"), preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        } else {
            let alertController = UIAlertController(title: nil, message:
                NSLocalizedString("mess3", comment: "Help"), preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
            reportList.append(titleTextField.text!)
            messageList.append(textField.text!)
            
        }
        //self.dismiss(animated: true)
    }
    
    //Pour faire dispaitre le clavier lorsqu'on appuie sur le bouton "entrée"
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textField.resignFirstResponder()
        titleTextField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        titleTextField.resignFirstResponder()
        return true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
