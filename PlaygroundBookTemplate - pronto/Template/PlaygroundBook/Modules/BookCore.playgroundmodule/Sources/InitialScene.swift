import SpriteKit
import Foundation
import AVFoundation

public class InitialScene: SKScene {
    lazy var background = childNode(withName: "initialScene") as? SKSpriteNode
    var startButtom = SKSpriteNode(imageNamed: "purpleButtom")
    var audioPlayer: AVAudioPlayer = AVAudioPlayer()
     
    
    override public func didMove(to view: SKView) {
        startButtom.position = CGPoint(x: -0.361, y: -216.162)
        startButtom.size = CGSize(width: 268.094, height: 100.468)
        addChild(startButtom)
        playButtonSound()
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
        if startButtom.contains(pos){
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
