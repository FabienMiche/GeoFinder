//
//  AudioViewController.swift
//  GeoFinder
//
//  Created by Fabien HOARAU on 11/2/19.
//  Copyright © 2019 Fabien HOARAU. All rights reserved.
//

import UIKit
import AVFoundation

class AudioViewController: UIViewController {
    
    @IBOutlet weak var audioLabel: UILabel!
    @IBOutlet weak var playBtnText: UIButton!
    @IBOutlet weak var pauseBtnText: UIButton!
    @IBOutlet weak var replayBtnText: UIButton!
    
    
    var audioPlayer = AVAudioPlayer()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        tabBarItem = UITabBarItem(title: NSLocalizedString("audio", comment: "Audio"), image: UIImage(named: "audio"), tag: 3)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioLabel.text = NSLocalizedString("titleAudio", comment: "Audio")
        playBtnText.setTitle(NSLocalizedString("play", comment: "Audio"), for: .normal)
        pauseBtnText.setTitle(NSLocalizedString("pause", comment: "Audio"), for: .normal)
        replayBtnText.setTitle(NSLocalizedString("replay", comment: "Audio"), for: .normal)
        
        //Musique par Kevin MacLeod
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "song", ofType: "mp3")!))
            audioPlayer.prepareToPlay()
            
            let audioSession = AVAudioSession.sharedInstance()
            do {
                try audioSession.setCategory(AVAudioSession.Category.playback)
            }
        } catch {
            print(error)
        }
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func playButtonPressed(_ sender: Any) {
        audioPlayer.play()
    }
    
    @IBAction func pauseButtonPressed(_ sender: Any) {
        audioPlayer.pause()
    }
    
    @IBAction func replayButtonPressed(_ sender: Any) {
        audioPlayer.currentTime = 0
    }
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
