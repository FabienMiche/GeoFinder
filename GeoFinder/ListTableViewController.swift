//
//  ListTableViewController.swift
//  GeoFinder
//
//  Created by Fabien HOARAU on 11/3/19.
//  Copyright © 2019 Fabien HOARAU. All rights reserved.
//

import UIKit

var geoList = ["Geo de chez moi", "Geo du PTU", "Geo de la fac"]
var geoLatitude = [-21.260, -20.905, -20.901]
var geoLongitude = [55.361, 55.500, 55.483]
var geoProxiLatitude = [-21.260, -20.905, -20.901]
var geoProxiLongitude = [55.361, 55.500, 55.483]
var geoInfo = ["On est bien chez soi ",
               "L'endroit préféré des licences et master d'informatique",
               "Le VRAI endroit préféré des des licences et master d'informatiques (ça dépend pour qui, en tout cas il y a plus de vie là-bas)"]
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
 
