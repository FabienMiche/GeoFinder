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
    @IBAction func startBtn(_ sender: Any) {
        startAudio.play()
    }
    
    
    

}

