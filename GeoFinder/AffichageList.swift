//
//  AffichageList.swift
//  GeoFinder
//
//  Created by Fabien HOARAU on 11/4/19.
//  Copyright © 2019 Fabien HOARAU. All rights reserved.
//

import UIKit
import AVFoundation


class AffichageList: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, AVAudioPlayerDelegate  {

    @IBOutlet weak var geoTitre: UILabel!
    @IBOutlet weak var geoLat: UILabel!
    @IBOutlet weak var geoLong: UILabel!
    @IBOutlet weak var geoDescription: UILabel!
    @IBOutlet weak var geoProxLat: UILabel!
    @IBOutlet weak var geoProxLong: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    var alertAudio = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        geoTitre.text = geoList[myIndex]
        geoLat.text = String(geoLatitude[myIndex])
        geoLong.text = String(geoLongitude[myIndex])
        geoDescription.text = geoInfo[myIndex]
        geoProxLat.text = String(geoProxiLatitude[myIndex])
        geoProxLong.text = String(geoProxiLongitude[myIndex])
        geoDescription.numberOfLines = 0
        geoDescription.sizeToFit()
        
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
    
    @IBAction func importBtn(_ sender: Any) {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: NSLocalizedString("photoSource", comment: "Photo"), message: NSLocalizedString("message", comment: "Photo"), preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: NSLocalizedString("camera", comment: "Photo"), style: .default, handler: { (action:UIAlertAction)in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            } else {
                print("Camera not available")
            }

        }))
        
        actionSheet.addAction(UIAlertAction(title: NSLocalizedString("library", comment: "Photo"), style: .default, handler: { (action:UIAlertAction)in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil )
        }))
        
        actionSheet.addAction(UIAlertAction(title: NSLocalizedString("cancel", comment: "Photo"), style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as!UIImage
        
        imageView.image = image
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
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
            performSegue(withIdentifier: "affichageSegue", sender: self)
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
