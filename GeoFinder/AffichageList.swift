//
//  AffichageList.swift
//  GeoFinder
//
//  Created by Fabien HOARAU on 11/4/19.
//  Copyright © 2019 Fabien HOARAU. All rights reserved.
//

import UIKit



class AffichageList: UIViewController {

    @IBOutlet weak var geoTitre: UILabel!
    @IBOutlet weak var geoLat: UILabel!
    @IBOutlet weak var geoLong: UILabel!
    @IBOutlet weak var geoDescription: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        geoTitre.text = geoList[myIndex]
        geoLat.text = String(geoLatitude[myIndex])
        geoLong.text = String(geoLongitude[myIndex])
        geoDescription.text = geoInfo[myIndex]
        
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
