/*:
 # WELCOME TO EQUILIBRIUM
 ## The game of life
  
 Aperte **start** e se desafie a encontrar o equilibrio em um ambiente nem sempre fácil ou justo (isso lembra alguma coisa, ne?)

 Para isso tente arrastar as bolinhas para os tanques de suas respectivas cores **por 1 minuto**.
  
  ---
  
  - Note: Para uma melhor experiência deixe o jogo em tela cheia
  
  */

//#-hidden-code
//Um pouco de código escondido (só funciona no iPad)

import PlaygroundSupport
import SpriteKit
import UIKit
import BookCore
import AVFoundation

let sceneView = SKView(frame: CGRect(x: 0, y: 0, width: 630, height: 886))

//private func playMusic() {
//
//        do {
//            music = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath:
//                Bundle.main.path(forResource: "calm", ofType: "mp3")!))
//            music.prepareToPlay()
//            music.numberOfLoops = -1
//            let audioSession = AVAudioSession.sharedInstance()
//            do {
//                try audioSession.setCategory(AVAudioSession.Category.playback)
//            }
//            catch {
//            }
//        }
//        catch {
//            print("Error: could not play theme song")
//        }
//        music.play()
//    }


if let scene = InitialScene(fileNamed: "InitialScene") {
    scene.scaleMode = .aspectFit
    sceneView.presentScene(scene)
}

PlaygroundPage.current.liveView = sceneView
PlaygroundPage.current.needsIndefiniteExecution = true

//#-end-hidden-code



