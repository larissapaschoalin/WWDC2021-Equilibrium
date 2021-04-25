//
//  GameController.swift
//  BookCore
//
//  Created by Larissa Paschoalin on 18/04/21.
//

import Foundation
import AVFoundation

public class GameController {
    public static var buttonPlayer: AVAudioPlayer = AVAudioPlayer()
    
    
    public static func playButtonSound() {
        do {
            guard let path = Bundle.main.path(forResource: "botao", ofType: "mp3") else { return }
            let url = URL(fileURLWithPath: path)
            buttonPlayer = try AVAudioPlayer(contentsOf: url)
            buttonPlayer.volume = 0.5
            buttonPlayer.prepareToPlay()
            buttonPlayer.play()
            
        } catch {
            return
        }
    }
    
}
