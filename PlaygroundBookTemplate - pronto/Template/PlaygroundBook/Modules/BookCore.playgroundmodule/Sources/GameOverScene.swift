import Foundation
import SpriteKit
import AVFoundation
import PlaygroundSupport


public class GameOverScene: SKScene {
    lazy var gameOver = childNode(withName: "gameOver") as? SKSpriteNode
    var tryAgainButton = SKSpriteNode(imageNamed: "blueButtom")
    var audioPlayer: AVAudioPlayer = AVAudioPlayer()
    var correntCardIndex = 0
    let messagens = [ "Dica: as vezes para conseguirmos equilibrar as coisas precisamos aceitar um ritmo mais lento"]
    
    override public func didMove(to view: SKView) {
        //playButtonSound()
        gameOver?.alpha = 0
        tryAgainButton.alpha = 0
        let fadeIn = SKAction.fadeIn(withDuration: 0.5)
        gameOver?.run(fadeIn)
        tryAgainButton.run(fadeIn)
        
        tryAgainButton.position = CGPoint(x: -0.361, y: -216.162)
        tryAgainButton.size = CGSize(width: 268.094, height: 100.468)
        addChild(tryAgainButton)
        showMessage(index: 0)
    }
    
    func showMessage (index:Int){
            PlaygroundPage.current.assessmentStatus = .pass(message: messagens[index])
    }
    
    func playButtonSound() {
        do {
            guard let path = Bundle.main.path(forResource: "botao", ofType: "mp3") else { return }
            let url = URL(fileURLWithPath: path)
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.prepareToPlay()
            audioPlayer.volume = 0.6
            audioPlayer.play()

            
        } catch {
            return
        }
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        if tryAgainButton.contains(pos){
            playButtonSound()
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
