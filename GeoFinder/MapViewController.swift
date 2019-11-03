//
//  MapViewController.swift
//  GeoFinder
//
//  Created by Fabien HOARAU on 11/2/19.
//  Copyright © 2019 Fabien HOARAU. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UITextFieldDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        tabBarItem = UITabBarItem(title: NSLocalizedString("map", comment: "Map"), image: UIImage(named: "carte"), tag: 1)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            
            //locationManager.requestWhenInUseAuthorization()
            locationManager.requestAlwaysAuthorization()
            
            mapView.showsUserLocation = true
        }
        else {
            let alert = UIAlertController(title: NSLocalizedString("error", comment: "Error"),
                                          message: NSLocalizedString("location not enabled", comment: "Error"),
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func whereAmI(_ sender: Any) {
        let userLocation = mapView.userLocation
        let region = MKCoordinateRegion(center: (userLocation.location?.coordinate)!,latitudinalMeters: 2000,longitudinalMeters: 2000)
        mapView.setRegion(region, animated: true)
    }
    
    
    @IBAction func standard(_ sender: Any) {
        mapView.mapType = .standard
    }
    
    @IBAction func satellite(_ sender: Any) {
        mapView.mapType = .satellite
    }
    
    @IBAction func hybrid(_ sender: Any) {
        mapView.mapType = .hybrid
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        currentLocation = userLocation.location
    }
    
    func mapView(_ mapView: MKMapView, didFailToLocateUserWithError error: Error) {
        let alert = UIAlertController(title: NSLocalizedString("error", comment: "Error"),
                                      message: NSLocalizedString("failed to update map", comment: "Error"),
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
