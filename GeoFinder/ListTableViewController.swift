//
//  ListTableViewController.swift
//  GeoFinder
//
//  Created by Fabien HOARAU on 11/3/19.
//  Copyright © 2019 Fabien HOARAU. All rights reserved.
//

import UIKit

var geoList = ["geo1", "geo2", "geo3"]
var geoLatitude = [2.0, 4.0, 5.5]
var geoLongitude = [1.0, 2.0, 3.0]
var geoInfo = ["Description de la geo1", "Description de la geo2", "Description de la geo3"]
var myIndex = 0


class ListTableViewController: UITableViewController {

    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        tabBarItem = UITabBarItem(title: NSLocalizedString("list", comment: "List"), image: UIImage(named: "liste"), tag: 2)
    }
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return geoList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = geoList[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        performSegue(withIdentifier: "segue", sender: self)
    }

}
 
