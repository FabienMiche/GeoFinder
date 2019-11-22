//
//  AffichageList.swift
//  GeoFinder
//
//  Created by Fabien HOARAU on 11/4/19.
//  Copyright © 2019 Fabien HOARAU. All rights reserved.
//

import UIKit
import AVFoundation     //Import pour la gestion des sons 

/*
 * Classe pour l'affichage des informations d'un objet
 * qu'on aura sélectionné dans la liste
 * Les informations sont récupérées depuis les tableaux de la classe "ListTableViewController"
*/


class AffichageList: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, AVAudioPlayerDelegate  {
    
    //Variables qui vont servir d'affichage dans le Main.storyboard
    
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
        
        /*
         * On récupère les valeurs des différents tableaux grâce à la variable myIndex
         * Les données sont récupérées et affichées dans les champs correspondants
         */
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
    
    /*
     * Action lorsqu'on appuie sur le bouton "importer"
     * qui offre la possibilité d'importer des photos depuis sa bibliothèque
     * ou bien d'en prendre une grâce à l'appareil (non fonctionnel sur les émulateurs)
     */
    @IBAction func importBtn(_ sender: Any) {
        
        let imagePickerController = UIImagePickerController()   //Variable qui permet de dire qu'on utilisera l'appareil photo
        imagePickerController.delegate = self
        
        //****** On définit des messages personnalisés ******
        let actionSheet = UIAlertController(title: NSLocalizedString("photoSource", comment: "Photo"), message: NSLocalizedString("message", comment: "Photo"), preferredStyle: .actionSheet)
        
        //Il faut vérifier si la camera est disponible ou non
        actionSheet.addAction(UIAlertAction(title: NSLocalizedString("camera", comment: "Photo"), style: .default, handler: { (action:UIAlertAction)in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            } else {
                print("Camera not available")
            }

        }))
        //******
        // Choix d'importer ou de prendre une photo
        actionSheet.addAction(UIAlertAction(title: NSLocalizedString("library", comment: "Photo"), style: .default, handler: { (action:UIAlertAction)in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil )
        }))
        
        actionSheet.addAction(UIAlertAction(title: NSLocalizedString("cancel", comment: "Photo"), style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    /*
     * On récupère la photo prise ou sélectionnée
     * et on l'affiche dans l'imageView du Main.storyboard
     */
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
            * Lorsqu'on secoue l'appareil on fait appel au view controller avec l'identifiant attribué
            * depuis le Main.storyboard, ici "mapSegue"
            */
            performSegue(withIdentifier: "affichageSegue", sender: self)
            alertAudio.play()
        }
    }
}
