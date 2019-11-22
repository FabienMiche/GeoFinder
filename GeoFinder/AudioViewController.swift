//
//  AudioViewController.swift
//  GeoFinder
//
//  Created by Fabien HOARAU on 11/2/19.
//  Copyright © 2019 Fabien HOARAU. All rights reserved.
//

import UIKit
import AVFoundation     //Import du module des sons

/*
 * Classe qui permet de jouer une boucle sonore
 * Trois boutons disponibles :
 * - Lecture
 * - Pause
 * - Rejouer
 
 * NOTE : La boucle sonore fournit dans cette application est libre d'utilisation.
 *        Musique : Funk Game Loop ~ Artiste : Kevin MacLeod ~ http://incompetech.com
 */

class AudioViewController: UIViewController {
    
    @IBOutlet weak var audioLabel: UILabel!
    @IBOutlet weak var playBtnText: UIButton!
    @IBOutlet weak var pauseBtnText: UIButton!
    @IBOutlet weak var replayBtnText: UIButton!
    
    
    var audioPlayer = AVAudioPlayer()
    
    //**** TAB BAR ****
    //On appel notre constructeur grâche la méthode init
    //UITabBarItem (title : "titre de l'item", image : choix d'une image personnalisée, tag : l'ordre de placement dans le "Tab bar"
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        tabBarItem = UITabBarItem(title: NSLocalizedString("audio", comment: "Audio"), image: UIImage(named: "audio"), tag: 3)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Pour les traductions
        audioLabel.text = NSLocalizedString("titleAudio", comment: "Audio")
        playBtnText.setTitle(NSLocalizedString("play", comment: "Audio"), for: .normal)
        pauseBtnText.setTitle(NSLocalizedString("pause", comment: "Audio"), for: .normal)
        replayBtnText.setTitle(NSLocalizedString("replay", comment: "Audio"), for: .normal)
        
        
        /*/
         * On cherche si le fichier source est bien présent
         * puis on utilise le module audio pour pouvoir effectuer
         * les actions nécessaires (lecture, pause,...)
         */
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "song", ofType: "mp3")!))
            audioPlayer.prepareToPlay()     //On charge le lecteur audio et le fichier source
            
            let audioSession = AVAudioSession.sharedInstance()
            do {
                try audioSession.setCategory(AVAudioSession.Category.playback)
            }
        } catch {
            print(error)
        }
    }
    
    /*
     * Les différentes actions effectuées
     * lorsqu'on appuie sur les boutons
     */
    
    @IBAction func playButtonPressed(_ sender: Any) {
        audioPlayer.play()          //Lecture
    }
    
    @IBAction func pauseButtonPressed(_ sender: Any) {
        audioPlayer.pause()         //Pause
    }
    
    @IBAction func replayButtonPressed(_ sender: Any) {
        audioPlayer.currentTime = 0 //On remet la piste à 0 et l'utilisateur peut la relancer
    }
}
