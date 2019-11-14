//
//  CheckViewController.swift
//  GeoFinder
//
//  Created by Fabien HOARAU on 11/12/19.
//  Copyright © 2019 Fabien HOARAU. All rights reserved.
//

import UIKit

class CheckViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var confirmBtnText: UIButton!
    @IBOutlet weak var labelBtn: UIButton!
    
    var test = "abcd"
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        tabBarItem = UITabBarItem(title: NSLocalizedString("check", comment: "Check"), image: UIImage(named: "check"), tag: 4)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self

        titleView.text = NSLocalizedString("title", comment: "Check")
        label.text = NSLocalizedString("label", comment: "Check")
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func confirmBtnPressed(_ sender: Any) {
        if textField.text! == test {
            let alertController = UIAlertController(title: nil, message:
                "Code Valide ! ", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        } else {
            let alertController = UIAlertController(title: nil, message:
                "Code incorrect", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    //Pour faire dispaitre le clavier lorsqu'on appuie sur le bouton "entrée"
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
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
