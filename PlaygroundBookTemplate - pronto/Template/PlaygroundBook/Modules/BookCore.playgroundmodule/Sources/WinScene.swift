import Foundation
import SpriteKit
import AVFoundation

public class WinScene: SKScene {
    lazy var winScene = childNode(withName: "winScene") as? SKSpriteNode
    var playAgainButtom = SKSpriteNode(imageNamed: "yellowButtom")
    var audioPlayer: AVAudioPlayer = AVAudioPlayer()


    
    override public func didMove(to view: SKView) {
        playButtonSound()
        winScene?.alpha = 0
        playAgainButtom.alpha = 0
        let fadeIn = SKAction.fadeIn(withDuration: 0.5)
        winScene?.run(fadeIn)
        playAgainButtom.run(fadeIn)
        
        playAgainButtom.position = CGPoint(x: 1.442, y: -315.268)
        playAgainButtom.size = CGSize(width: 268.094, height: 100.468)
  
        addChild(playAgainButtom)
    }
    
    func playButtonSound() {
        do {
            guard let path = Bundle.main.path(forResource: "botao", ofType: "mp3") else { return }
            let url = URL(fileURLWithPath: path)
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.prepareToPlay()
            audioPlayer.volume = 0.3
            
        } catch {
            return
        }
    }
    
    func touchDown(atPoint pos : CGPoint) {
        if playAgainButtom.contains(pos){
            audioPlayer.play()
            let scene = GameScene(fileNamed: "GameScene")!
            scene.scaleMode = .aspectFit
            self.view?.presentScene(scene)
        }
    }

    func touchMoved(toPoint pos : CGPoint) {
        
    }

    func touchUp(atPoint pos : CGPoint) {
       
    }

    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchDown(atPoint: t.location(in: self)) }
    }

    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchMoved(toPoint: t.location(in: self)) }
    }

    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchUp(atPoint: t.location(in: self)) }
    }

    override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchUp(atPoint: t.location(in: self)) }
    }
}
