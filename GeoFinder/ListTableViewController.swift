//
//  ListTableViewController.swift
//  GeoFinder
//
//  Created by Fabien HOARAU on 11/3/19.
//  Copyright © 2019 Fabien HOARAU. All rights reserved.
//

import UIKit
import AVFoundation     //Import pour la gestion des sons 

//******** Affichage de la liste des geocaches ********
/*
 *On définit les informations nécessaires pounr une geocaches
 *à savoir :
 * - nom
 * - coordonnées : latitude et longitude
 * - coordonnées pour la zone de proximité
 * - un description
 */


var geoList: [String?] = ["Geo de chez moi", "Geo du PTU", "Geo de la fac", "Another one"]
var geoLatitude = [-21.260, -20.905, -20.901, -12.345]
var geoLongitude = [55.361, 55.500, 55.483,23.345]
var geoProxiLatitude = [-21.260, -20.905, -20.901,23.434]
var geoProxiLongitude = [55.361, 55.500, 55.483,23.234]
var geoInfo: [String?] = ["On est bien chez soi ",
               "L'endroit préféré des licences et master d'informatique",
               "Le VRAI endroit préféré des des licences et master d'informatiques (ça dépend pour qui, en tout cas il y a plus de vie là-bas)", "Il n'y en a jamais assez pour tester"]
var myIndex = 0     //variable qui va service de référence lorsqu'on choisis un élément du tableau 


class ListTableViewController: UITableViewController, AVAudioPlayerDelegate {

    
    var alertAudio = AVAudioPlayer()
    
    
    //**** TAB BAR ****
    //On appel notre constructeur grâche la méthode init
    //UITabBarItem (title : "titre de l'item", image : choix d'une image personnalisée, tag : l'ordre de placement dans le "Tab bar"
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        tabBarItem = UITabBarItem(title: NSLocalizedString("list", comment: "List"), image: UIImage(named: "liste"), tag: 2)
    }
    
    

    // MARK: - Table view data source
    
    /*
     * Chaque valeur est stockée dans un tableau
     * La fonction ci-dessous permet de compter et de retourner le nombre d'éléments dans geoList
     * On récupère ces valeurs et on les affiches sur la Table View
     * afin que l'utilisateur puisse intérargir avec
    */
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //On retourne le nombre d'éléments présents dans la liste
        return geoList.count
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = geoList[indexPath.row]
        
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

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row                             //On récupère l'indice sélectionné dans la liste par l'utilisateur
        performSegue(withIdentifier: "segue", sender: self) //On est redirigé vers l'affichage des informations d'une geocache avec la l'indice pris en compte
    }
    
    
    /*
     * Fonction pour pouvoir supprimer un élément de la liste
     * par un simple glissé de la droite vers la gauche
     */
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            geoList.remove(at: indexPath.row)                           //On supprime l'élément
            
            /*
             * Utilisation de UserDefaults pour le stockage des données
             * Ici, lorsque l'utilisateur supprime un élément
             * on supprime toutes les valeurs qui lui sont associées
             * c'est-à-dire on passe par tous les tableaux
             * et supprime chaque élément correspondant
             */
            UserDefaults.standard.removeObject(forKey: "geoList")
            UserDefaults.standard.removeObject(forKey: "geoLat")
            UserDefaults.standard.removeObject(forKey: "geoLong")
            UserDefaults.standard.removeObject(forKey: "geoProxLat")
            UserDefaults.standard.removeObject(forKey: "geoProxLong")
            UserDefaults.standard.removeObject(forKey: "geoInfo")
            tableView.reloadData()
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
            /*
            * Lorsqu'on secoue l'appareil on fait appel au view controller avec l'identifiant attribué
            * depuis le Main.storyboard, ici "mapSegue"
            */
            performSegue(withIdentifier: "listSegue", sender: self)
            alertAudio.play()
        }
    }

    //*************

}
 
