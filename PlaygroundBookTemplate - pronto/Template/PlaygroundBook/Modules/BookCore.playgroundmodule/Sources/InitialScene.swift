//
//  InitialScene.swift
//  BookCore
//
//  Created by Larissa Paschoalin on 16/04/21.
//
import SpriteKit
import Foundation

public class InitialScene: SKScene {
    lazy var background = childNode(withName: "initialScene") as? SKSpriteNode
    var startButtom = SKSpriteNode(imageNamed: "purpleButtom")
    
    override public func didMove(to view: SKView) {
        startButtom.position = CGPoint(x: 0, y: -244.649)
        startButtom.size = CGSize(width: 283.022, height: 100.768)
        addChild(startButtom)
    }
    
    func touchDown(atPoint pos : CGPoint) {
        if startButtom.contains(pos){
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
