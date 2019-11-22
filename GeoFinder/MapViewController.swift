//
//  MapViewController.swift
//  GeoFinder
//
//  Created by Fabien HOARAU on 11/2/19.
//  Copyright © 2019 Fabien HOARAU. All rights reserved.
//

import UIKit
import MapKit           //Import pour la carte
import CoreLocation     //Import pour la position geographique
import AVFoundation     //Import pour la gestion des sons



class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, AVAudioPlayerDelegate {
    
    //**** AFFICHAGE DE LA CARTE ****
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var latitudeText: UILabel!
    @IBOutlet weak var longitudeText: UILabel!
    
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    
    var alertAudio = AVAudioPlayer()
    var alertProximiteAudio = AVAudioPlayer()
    
    
    //**** ZONE DE PROXIMITÉ ****
    //On définit nos zones de proximités ici
    let geo = CLCircularRegion(center: CLLocationCoordinate2DMake(geoProxiLatitude[0], geoProxiLongitude[0]), radius: 100.0, identifier: "Geo1")
    let geo2 = CLCircularRegion(center: CLLocationCoordinate2DMake(geoProxiLatitude[1], geoProxiLongitude[1]), radius: 100.0, identifier: "Geo2")
    let geo3 = CLCircularRegion(center: CLLocationCoordinate2DMake(geoProxiLatitude[2], geoProxiLongitude[2]), radius: 100.0, identifier: "Geo3")
    
    
    
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
            locationManager.startMonitoring(for: geo)           //Pour la zone de proximité de la geocache
            
            locationManager.startUpdatingLocation()
            
            mapView.showsUserLocation = true                    //On récupère la position de l'utilisateur
            
        } else {
            //Gestion des erreurs si on arrive pas à récupérer la position de l'utilisateur
            let alert = UIAlertController(title: NSLocalizedString("error", comment: "Error"),
                                          message: NSLocalizedString("location not enabled", comment: "Error"),
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        //**** Chargement des fichiers sons ****
        //Son : Alerte de proximité
        //On teste l'existence du fichier source
        if let soundFilePath = Bundle.main.path(forResource: "alertProximité", ofType: "wav") {
            let fileURL = URL(fileURLWithPath: soundFilePath)
            do {
                try alertProximiteAudio = AVAudioPlayer(contentsOf: fileURL)
                alertProximiteAudio.delegate = self
                
            } catch {
                print("Erreur :",  error)
                
            }
        }
        
        //Son : alert lorsqu'on secoue l'appareil
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
        
    }
    
    //**** On récupère et on affiche les coordonnées (latitude et longitude) sur la carte ****
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("Locations = \(locValue.latitude) \(locValue.longitude)")
        latitudeText.text = String(format: "%.3f",locValue.latitude)
        longitudeText.text = String(format: "%.3f",locValue.longitude)
    }
    //********
    
    
    //**** Alerte de proximité des geocaches ****
    //ENTRÉE DANS LA ZONE DE PROXIMITÉ
    //Un son est joué et une alerte s'affiche pour prévenir l'utilisateur
    func locationManager(_ manager: CLLocationManager, didEnterRegion geo1: CLRegion) {
        print("Entrée dans la zone de %@", geo1)
        let alertController = UIAlertController(title: NSLocalizedString("alert", comment: "Zone"), message: NSLocalizedString("messageEnter", comment: "Error"), preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alertController, animated: true, completion: nil)
        alertProximiteAudio.play()
    }

    
    //SORTIE DE LA ZONE DE PROXIMITÉ
    func locationManager(_ manager: CLLocationManager, didExitRegion geo1: CLRegion) {
        print("Sortie de la zone %@", geo1)
        let alertController = UIAlertController(title: NSLocalizedString("alert", comment: "Zone"), message: NSLocalizedString("messageExit", comment: "Zone"), preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alertController, animated: true, completion: nil)
        alertProximiteAudio.play()
    }
    
    
    //********
    
    //Bouton pour zoomer sur la position actuel de l'utilisateur
    @IBAction func whereAmI(_ sender: Any) {
        let userLocation = mapView.userLocation
        let region = MKCoordinateRegion(center: (userLocation.location?.coordinate)!,latitudinalMeters: 2000,longitudinalMeters: 2000)
        mapView.setRegion(region, animated: true)
    }
    
    //********
    //Différents types d'affichage de la carte
    @IBAction func standard(_ sender: Any) {
        mapView.mapType = .standard
    }
    
    @IBAction func satellite(_ sender: Any) {
        mapView.mapType = .satellite
    }
    
    @IBAction func hybrid(_ sender: Any) {
        mapView.mapType = .hybrid
    }
    
    //********
    
    
    
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
            /*
             Ancien test : affichage d'un simple message
            let alertController = UIAlertController(title: nil, message:
                "C'est bien ça marche :D", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
            */
            
            /*
             * Lorsqu'on secoue l'appareil on fait appel au view controller avec l'identifiant attribué
             * depuis le Main.storyboard, ici "mapSegue"
            */
            performSegue(withIdentifier: "mapSegue", sender: self)
            alertAudio.play()
        }
    }
}
