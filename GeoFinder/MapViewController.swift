//
//  MapViewController.swift
//  GeoFinder
//
//  Created by Fabien HOARAU on 11/2/19.
//  Copyright © 2019 Fabien HOARAU. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import AVFoundation

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, AVAudioPlayerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var latitudeText: UILabel!
    @IBOutlet weak var longitudeText: UILabel!
    
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    
    var alertAudio = AVAudioPlayer()
    var alertProximiteAudio = AVAudioPlayer()
    //private var showingAlert = false
    
    //**** ZONE DE PROXIMITÉ ****
    //On définit nos zones de proximités ici
    let region = CLCircularRegion(center: CLLocationCoordinate2DMake(-33.8634, 151.211), radius: 100000.0, identifier: "Sydney")
    
    //**** TAB BAR ****
    //On appel notre constructeur grâche la méthode init
    //UITabBarItem (title : "titre de l'item", image : choix d'une image personnalisée, tag : l'ordre de placement dans le "Tab bar"
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        tabBarItem = UITabBarItem(title: NSLocalizedString("map", comment: "Map"), image: UIImage(named: "carte"), tag: 1)
    }
    
    //********
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            
            //locationManager.requestWhenInUseAuthorization()
            locationManager.requestAlwaysAuthorization()
            locationManager.startMonitoring(for: region)    //Pour la zone de proximité
            locationManager.startUpdatingLocation()
            
            mapView.showsUserLocation = true
            
        } else {
            let alert = UIAlertController(title: NSLocalizedString("error", comment: "Error"),
                                          message: NSLocalizedString("location not enabled", comment: "Error"),
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        //**** Chargement des fichiers sons ****
        if let soundFilePath = Bundle.main.path(forResource: "alertProximité", ofType: "wav") {
            let fileURL = URL(fileURLWithPath: soundFilePath)
            do {
                try alertProximiteAudio = AVAudioPlayer(contentsOf: fileURL)
                alertProximiteAudio.delegate = self
                
            } catch {
                print("Erreur :",  error)
                
            }
        }
        
        if let soundFilePath = Bundle.main.path(forResource: "alert", ofType: "mp3") {
            let fileURL = URL(fileURLWithPath: soundFilePath)
            do {
                try alertAudio = AVAudioPlayer(contentsOf: fileURL)
                alertAudio.delegate = self
                
            } catch {
                print("Erreur :",  error)
                
            }
        }
        //********
        // Do any additional setup after loading the view.
        
    }
    
    //**** On récupère et on affiche les coordonnées (latitude et longitude) sur la carte ****
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("Locations = \(locValue.latitude) \(locValue.longitude)")
        latitudeText.text = String(locValue.latitude)
        longitudeText.text = String(locValue.longitude)
    }
    //********
    
    //**** Alerte lorsqu'on rentre dans une zone de proximité ****
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("Entrée dans la zone %@", region)
        let alertController = UIAlertController(title: "Attention", message: "Entrée dans la zone ", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alertController, animated: true, completion: nil)
        alertProximiteAudio.play()
    }
    //********
    
    //**** Alerte lorsqu'on sort dans une zone de proximité ****
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("Sortie de la zone %@", region)
        let alertController = UIAlertController(title: "Attention", message: "Sortie de la zone ", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alertController, animated: true, completion: nil)
        alertProximiteAudio.play()
    }
    //********
    
    
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
    
    
    //*************
    //Fonction pour la détection du mouvement du téléphone
    //Quand on secoue l'appareil, les fonctions suivantes sont appelées
    override func becomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake
        {
            let alertController = UIAlertController(title: nil, message:
                "C'est bien ça marche :D", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
            alertAudio.play()
        }
    }
    
    //*************
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
