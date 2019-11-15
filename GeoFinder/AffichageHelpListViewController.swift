//
//  AffichageHelpListViewController.swift
//  GeoFinder
//
//  Created by Fabien HOARAU on 11/14/19.
//  Copyright © 2019 Fabien HOARAU. All rights reserved.
//

import UIKit

class AffichageHelpListViewController: UIViewController {

    @IBOutlet weak var titreLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titreLabel.text = reportList[valueIndex]
        messageLabel.text = messageList[valueIndex]
        messageLabel.numberOfLines = 0
        messageLabel.sizeToFit()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func exitButton(_ sender: Any) {
        self.dismiss(animated: true)
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
