import Foundation
import SpriteKit


public class GameOverScene: SKScene {
    lazy var gameOver = childNode(withName: "gameOver") as? SKSpriteNode
    var tryAgainButtom = SKSpriteNode(imageNamed: "blueButtom")
    
    override public func didMove(to view: SKView) {
        gameOver?.alpha = 0
        tryAgainButtom.alpha = 0
        let fadeIn = SKAction.fadeIn(withDuration: 0.5)
        gameOver?.run(fadeIn)
        tryAgainButtom.run(fadeIn)
        
        tryAgainButtom.position = CGPoint(x: -0.361, y: -216.162)
        tryAgainButtom.size = CGSize(width: 268.094, height: 100.468)
        addChild(tryAgainButtom)
    }
    func touchDown(atPoint pos : CGPoint) {
        if tryAgainButtom.contains(pos){
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
