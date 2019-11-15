//
//  HelpListViewController.swift
//  GeoFinder
//
//  Created by Fabien HOARAU on 11/14/19.
//  Copyright © 2019 Fabien HOARAU. All rights reserved.
//

import UIKit

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
        let cell = tableView.dequeueReusableCell(withIdentifier: "helpCell", for: indexPath)

        cell.textLabel?.text = reportList[indexPath.row]

        return cell
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        valueIndex = indexPath.row
        performSegue(withIdentifier: "segueHelp", sender: self)
    }
    
    @IBAction func returnButtonTable(_ sender: Any) {
        self.dismiss(animated: true)
    }
    

}
