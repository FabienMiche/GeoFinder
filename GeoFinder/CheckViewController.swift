//
//  CheckViewController.swift
//  GeoFinder
//
//  Created by Fabien HOARAU on 11/12/19.
//  Copyright © 2019 Fabien HOARAU. All rights reserved.
//

import UIKit
import AVFoundation

class CheckViewController: UIViewController, UITextFieldDelegate, AVAudioPlayerDelegate {

    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var confirmBtnText: UIButton!
    @IBOutlet weak var labelBtn: UIButton!
    
    var test = "abcd"
    var alertAudio = AVAudioPlayer()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        tabBarItem = UITabBarItem(title: NSLocalizedString("check", comment: "Check"), image: UIImage(named: "check"), tag: 4)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self

        titleView.text = NSLocalizedString("title", comment: "Check")
        label.text = NSLocalizedString("label", comment: "Check")
        
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
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func confirmBtnPressed(_ sender: Any) {
        if textField.text! == test {
            let alertController = UIAlertController(title: nil, message:
                "Code Valide ! ", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        } else {
            let alertController = UIAlertController(title: nil, message:
                "Code incorrect", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    //Pour faire dispaitre le clavier lorsqu'on appuie sur le bouton "entrée"
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
            let alertController = UIAlertController(title: nil, message:
                "C'est bien ça marche :D", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
            */
            performSegue(withIdentifier: "checkSegue", sender: self)
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
