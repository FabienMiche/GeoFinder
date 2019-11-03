//
//  MyAnnotation.swift
//  GeoFinder
//
//  Created by Fabien HOARAU on 11/3/19.
//  Copyright © 2019 Fabien HOARAU. All rights reserved.
//

import UIKit
import MapKit

class MyAnnotation: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var title:String?
    var subtitle: String?

    init(coordinate aCoordinate: CLLocationCoordinate2D, title aTitle: String?) {
        self.coordinate = aCoordinate
        self.title = aTitle
        super.init()
    }
}
