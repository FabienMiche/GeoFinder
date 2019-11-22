//
//  HelpViewController.swift
//  GeoFinder
//
//  Created by Fabien HOARAU on 11/14/19.
//  Copyright © 2019 Fabien HOARAU. All rights reserved.
//

import UIKit

/*
 * Classe pour signaler un problème
 * Lorsque l'utilisateur secoue son appareil
 * Une nouvelle fenêtre apparaît avec deux champs de textes
 * "Titre", pour le sujet du message et "Message", les explications du problème
 */

class HelpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var reportsListButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
         Nécessaire pour récupérer la saisie de l'utilisateur
         */
        textField.delegate = self
        titleTextField.delegate = self
        
        
        //Traductions
        cancelButton.setTitle(NSLocalizedString("cancelBtn", comment: "Help"), for: .normal)
        confirmButton.setTitle(NSLocalizedString("confirmBtn", comment: "Help"), for: .normal)
        reportsListButton.setTitle(NSLocalizedString("reportList", comment: "Help"), for: .normal)
    }
    
    //Pour quitter la vue
    @IBAction func cancelBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    /*
     * On veut vérifier que l'utilisateur a bien rempli tous les champs
     * On aura 2 conditions : si un champ est vide -> erreur
     *                        si la longueur du titre et du message est < 4
     * Si les conditions sont remplies, le titre et le message sont stockés dans un tableau (voir classe HelpListViewController)
     * L'utilisateur peut consulter la liste des rapports envoyés
     */
    @IBAction func confirmBtn(_ sender: Any) {
        if textField.text! == "" || titleTextField.text! == "" {
            let alertController = UIAlertController(title: nil, message:NSLocalizedString("mess1", comment: "Help"), preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        } else if textField.text!.count <= 5 || titleTextField.text!.count <= 5 {
            let alertController = UIAlertController(title: nil, message:NSLocalizedString("mess2", comment: "Help"), preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        } else {
            let alertController = UIAlertController(title: nil, message:
                NSLocalizedString("mess3", comment: "Help"), preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
            
            reportList.append(titleTextField.text!)
            messageList.append(textField.text!)
            
            /*
             * On enregistre le contenu des tableaux dans UserDefaults
             * UserDefaults est une interface vers la base de données
             * par défaut de l'appareil de l'utilisateur
            */
            UserDefaults.standard.set(reportList, forKey: "reportList")
            UserDefaults.standard.set(messageList, forKey: "messageList")
            //*****
        }
    }
    
    //***** Pour enregistrer de façon permanente *****
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.object(forKey: "reportList") as? [String] != nil {
            reportList = UserDefaults.standard.object(forKey: "reportList") as? [String] ?? [String]()
        }
        
        if UserDefaults.standard.object(forKey: "messageList") as? [String] != nil {
            messageList = UserDefaults.standard.object(forKey: "messageList") as? [String] ?? [String]()
        }
    }
    //*****
    
    //Pour faire disparaitre le clavier lorsqu'on appuie sur le bouton "entrée"
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textField.resignFirstResponder()
        titleTextField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        titleTextField.resignFirstResponder()
        return true
    }
}
