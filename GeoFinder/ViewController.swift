//
//  ViewController.swift
//  GeoFinder
//
//  Created by Fabien HOARAU on 11/2/19.
//  Copyright © 2019 Fabien HOARAU. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {

    var alertAudio = AVAudioPlayer()
    var startAudio = AVAudioPlayer()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //**** Chargement des fichiers sons ****
        //Son d'alerte
        if let soundFilePath = Bundle.main.path(forResource: "alert", ofType: "mp3") {
            let fileURL = URL(fileURLWithPath: soundFilePath)
            do {
                try alertAudio = AVAudioPlayer(contentsOf: fileURL)
                alertAudio.delegate = self
            } catch {
                print("Erreur :",  error)
            }
        }
        
        //Son bouton démarrer
        if let soundFilePath = Bundle.main.path(forResource: "start", ofType: "wav") {
            let fileURL = URL(fileURLWithPath: soundFilePath)
            do {
                try startAudio = AVAudioPlayer(contentsOf: fileURL)
                startAudio.delegate = self
            } catch {
                print("Erreur :",  error)
            }
        }
        //********
        
    }
    
    //Pour stocker les données de façons permanente
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.object(forKey: "geoList") as? [String] != nil {
            geoList = UserDefaults.standard.object(forKey: "geoList") as? [String] ?? [String]()
        }
        
        if UserDefaults.standard.object(forKey: "geoLat") as? [Double] != nil {
            geoLatitude = UserDefaults.standard.object(forKey: "geoLat") as? [Double] ?? [Double]()
        }
        
        if UserDefaults.standard.object(forKey: "geoLong") as? [Double] != nil {
            geoLongitude = UserDefaults.standard.object(forKey: "geoLong") as? [Double] ?? [Double]()
        }
        
        if UserDefaults.standard.object(forKey: "geoProxLat") as? [Double] != nil {
            geoProxiLatitude = UserDefaults.standard.object(forKey: "geoProxLat") as? [Double] ?? [Double]()
        }
        
        if UserDefaults.standard.object(forKey: "geoProxLong") as? [Double] != nil {
            geoProxiLongitude = UserDefaults.standard.object(forKey: "geoProxLong") as? [Double] ?? [Double]()
        }
        
        if UserDefaults.standard.object(forKey: "geoInfo") as? [String] != nil {
            geoInfo = UserDefaults.standard.object(forKey: "geoInfo") as? [String] ?? [String]()
        }
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
            performSegue(withIdentifier: "menuSeg", sender: self)
            alertAudio.play()
        }
    }

    //*************
    /*
    * Utilisation de UserDefaults pour le stockage des données
    * Ici, lorsque l'utilisateur supprime un élément
    * on supprime toutes les valeurs qui lui sont associées
    * c'est-à-dire on passe par tous les tableaux
    * et supprime chaque élément correspondant
    */
    @IBAction func startBtn(_ sender: Any) {
        UserDefaults.standard.set(geoList, forKey: "geoList")
        UserDefaults.standard.set(geoLatitude, forKey: "geoLat")
        UserDefaults.standard.set(geoLongitude, forKey: "geoLong")
        UserDefaults.standard.set(geoProxiLatitude, forKey: "geoProxLat")
        UserDefaults.standard.set(geoProxiLongitude, forKey: "geoProxLong")
        UserDefaults.standard.set(geoInfo, forKey: "geoInfo")
        startAudio.play()
    }
}

