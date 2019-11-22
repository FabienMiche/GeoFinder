//
//  AddGeoViewController.swift
//  GeoFinder
//
//  Created by Fabien HOARAU on 11/21/19.
//  Copyright © 2019 Fabien HOARAU. All rights reserved.
//

import UIKit

/*
 * Classe pour l'ajout des geocaches
 * Comme pour l'ajout des rapports
 * L'utilisateur doit renseigner toutes les informations nécessaires
 */

class AddGeoViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet weak var nameTxtField: UITextField!
    @IBOutlet weak var latTxtField: UITextField!
    @IBOutlet weak var longTxtField: UITextField!
    
    @IBOutlet weak var proxLatTxtField: UITextField!
    @IBOutlet weak var proxLongTxtField: UITextField!
    
    @IBOutlet weak var descTxtView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        nameTxtField.delegate = self
        latTxtField.delegate = self
        longTxtField.delegate = self
        
        proxLatTxtField.delegate = self
        proxLongTxtField.delegate = self
        
        descTxtView.delegate = self
    }
    
    
    @IBAction func cancelAddBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    /*
     * On vérifie que les tous les champs sont bien remplis
     */
    @IBAction func confirmAddBtn(_ sender: Any) {
        if nameTxtField.text! == "" || latTxtField.text! == "" || longTxtField.text! == "" || proxLatTxtField.text! == "" || proxLongTxtField.text! == "" || descTxtView.text! == "" {
            let alertController = UIAlertController(title: nil, message:NSLocalizedString("err1", comment: "Add"), preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
        } else {
            let alertController = UIAlertController(title: nil, message:NSLocalizedString("success", comment: "Add"), preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
            
            geoList.append(nameTxtField.text!)
            geoLatitude.append(Double(latTxtField.text!)!)
            geoLongitude.append(Double(longTxtField.text!)!)
            geoProxiLatitude.append(Double(proxLongTxtField.text!)!)
            geoProxiLongitude.append(Double(proxLongTxtField.text!)!)
            geoInfo.append(descTxtView.text!)
            
            /*
            * Utilisation de UserDefaults pour le stockage des données
            * Ici, lorsque l'utilisateur supprime un élément
            * on supprime toutes les valeurs qui lui sont associées
            * c'est-à-dire on passe par tous les tableaux
            * et supprime chaque élément correspondant
            */
            UserDefaults.standard.set(geoList, forKey: "geoList")
            UserDefaults.standard.set(geoLatitude, forKey: "geoLat")
            UserDefaults.standard.set(geoLongitude, forKey: "geoLong")
            UserDefaults.standard.set(geoProxiLatitude, forKey: "geoProxLat")
            UserDefaults.standard.set(geoProxiLongitude, forKey: "geoProxLong")
            UserDefaults.standard.set(geoInfo, forKey: "geoInfo")
            
        }
    }
    
    //***** Pour stocker les données de façons permanente
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
    
    //*****
    
    //***** Pour faire dispaitre le clavier lorsqu'on appuie sur le bouton "entrée"
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        nameTxtField.resignFirstResponder()
        latTxtField.resignFirstResponder()
        longTxtField.resignFirstResponder()
        proxLatTxtField.resignFirstResponder()
        proxLongTxtField.resignFirstResponder()
        descTxtView.resignFirstResponder()
    }
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTxtField.resignFirstResponder()
        latTxtField.resignFirstResponder()
        longTxtField.resignFirstResponder()
        proxLatTxtField.resignFirstResponder()
        proxLongTxtField.resignFirstResponder()
        descTxtView.resignFirstResponder()
        return true
    }
    //*****
}
