//
//  HelpListViewController.swift
//  GeoFinder
//
//  Created by Fabien HOARAU on 11/14/19.
//  Copyright © 2019 Fabien HOARAU. All rights reserved.
//

import UIKit

/*
 * Classe qui contient les informations des rapports
 * Cette classe fonctionne de la même manière que ListTableViewController
 */

var reportList: [String?] = []
var messageList: [String?] = []
var valueIndex  = 0

class HelpListViewController: UITableViewController {

    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return reportList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell2 = tableView.dequeueReusableCell(withIdentifier: "helpCell", for: indexPath)

        cell2.textLabel?.text = reportList[indexPath.row]

        return cell2
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            reportList.remove(at: indexPath.row)
            UserDefaults.standard.removeObject(forKey: "reportList")
            UserDefaults.standard.removeObject(forKey: "messageList")
            tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        valueIndex = indexPath.row
        performSegue(withIdentifier: "segueHelp", sender: self)
    }
    
    //Pour quitter la vue
    @IBAction func returnButtonTable(_ sender: Any) {
        self.dismiss(animated: true)
    }
    

}
