import SpriteKit

public class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var colors: [UIColor] = []
    var balls = [SKShapeNode]()
    var selectedBall: SKShapeNode!
    var goalBlue: SKSpriteNode!
    var goalYellow: SKSpriteNode!
    var goalPurple: SKSpriteNode!
    let backgroud = SKSpriteNode(imageNamed: "background")
    let stroke = SKSpriteNode(imageNamed: "stroke")

    public override func sceneDidLoad() {
        let xBlue = UIColor(red: 33/255, green: 217/255, blue: 237/255, alpha: 1.0)
        let xPurple = UIColor(red: 119/255, green: 115/255, blue: 234/255, alpha: 1.0)
        let xYellow = UIColor(red: 255/255, green: 184/255, blue: 8/255, alpha: 1.0)
        colors = [xBlue, xPurple, xYellow]
    }
    
    func makeBall(at position: CGPoint, color: Int) {
        let ball = SKShapeNode(circleOfRadius: 30)
        ball.fillColor = colors[color]
        ball.strokeColor = UIColor.black
        ball.position = position
        ball.zPosition = 11
        ball.name = "color-\(color)-ball"
        ball.physicsBody = SKPhysicsBody(circleOfRadius: 20)
        ball.physicsBody?.isDynamic = true
        ball.physicsBody?.affectedByGravity = false
        ball.physicsBody?.allowsRotation = true
        ball.physicsBody?.restitution = 1.1
        ball.physicsBody?.collisionBitMask = 2
        ball.physicsBody?.mass = 2
        ball.physicsBody?.contactTestBitMask = ball.physicsBody!.collisionBitMask
        self.addChild(ball)
        balls.append(ball)
        
        ball.physicsBody?.applyImpulse(.init(dx: 1000, dy: 1000))
    }

    override public func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        
        backgroud.position.x = self.frame.midX
        backgroud.position.y = self.frame.midY
        backgroud.setScale(0.35)

        addChild(backgroud)
        
        stroke.position.x = self.frame.midX
        stroke.position.y = self.frame.midY
        stroke.setScale(1)

        addChild(stroke)
        
        let xRed = UIColor(red: 231/255, green: 95/255, blue: 93/255, alpha: 1.0)
        var timeBar: SKSpriteNode!
        timeBar = SKSpriteNode(color: xRed, size: .init(width: self.size.width, height: 30))
        timeBar.position = CGPoint(x: self.size.width / -2, y: self.size.height / 2)
        timeBar.anchorPoint = .init(x: 0, y: 0.5)
        addChild(timeBar)
    
        
        let maxTime = 60
        timeBar.run(.repeat(.sequence([
            .run {
                let increase: CGFloat = CGFloat(self.size.width) / CGFloat(maxTime)
                timeBar.size = CGSize(width: timeBar.size.width - increase, height: timeBar.size.height)
                if timeBar.size.width <= 9.50 {
                    let winScene = WinScene(fileNamed: "WinScene")!
//                    let winScene = SKSpriteNode(imageNamed: "winScene")
//                    winScene.zPosition = 12
//                    winScene.position.x = self.frame.midX
//                    winScene.position.y = self.frame.midY
//                    winScene.alpha = 0
//                    let fadeIn = SKAction.fadeIn(withDuration: 1)
//                    winScene.run(fadeIn)
                    self.view?.presentScene(winScene)
                }
            },
            .wait(forDuration: 1)
        ]), count: maxTime))
        

        goalBlue = SKSpriteNode(color: colors[0], size: .init(width: 210, height: 336))
        goalBlue.position = CGPoint(x: -210, y:-85)
        goalBlue.anchorPoint = .init(x: 0.5, y: 1)
        let centerPointBlue = CGPoint(x: goalBlue.size.width / 2 - (goalBlue.size.width * goalBlue.anchorPoint.x), y:goalBlue.size.height / 2 - (goalBlue.size.height * goalBlue.anchorPoint.y))
        goalBlue.physicsBody = SKPhysicsBody(rectangleOf: goalBlue.size, center: centerPointBlue)
        goalBlue.physicsBody?.isDynamic = false
        goalBlue.name = "color-0-goal"
        goalBlue.zPosition = 3
        addChild(goalBlue)
        
        let maxSize = 50
        goalBlue.run(.repeatForever(.sequence([
            .run {
                let increase: CGFloat = CGFloat(self.goalBlue.size.width) / CGFloat(maxSize)
                self.goalBlue.size = CGSize(width: 210, height: self.goalBlue.size.height - increase)
                if self.goalBlue.size.height <= 2 {
                    let gameOverScene = GameOverScene(fileNamed: "GameOverScene")!
                    gameOverScene.scaleMode = .aspectFit
                    self.view?.presentScene(gameOverScene)
                    self.goalBlue.removeAllActions()
                }
            },
            .wait(forDuration: 1)
        ])))
        
        goalPurple = SKSpriteNode(color: colors[1], size: .init(width: 210, height: 336))
        goalPurple.position = CGPoint(x: 0, y:-85)
        goalPurple.anchorPoint = .init(x: 0.5, y: 1)
        let centerPointPurple = CGPoint(x: goalPurple.size.width / 2 - (goalPurple.size.width * goalPurple.anchorPoint.x), y:goalPurple.size.height / 2 - (goalPurple.size.height * goalPurple.anchorPoint.y))
        goalPurple.physicsBody = SKPhysicsBody(rectangleOf: goalPurple.size, center: centerPointPurple)
        goalPurple.physicsBody?.isDynamic = false
        goalPurple.physicsBody!.collisionBitMask = 2
        goalPurple.physicsBody?.contactTestBitMask = goalPurple.physicsBody!.collisionBitMask
        goalPurple.name = "color-1-goal"
        goalPurple.zPosition = 3
        addChild(goalPurple)
        

        goalPurple.run(.repeatForever(.sequence([
            .run {
                let increase: CGFloat = CGFloat(self.goalPurple.size.width) / CGFloat(maxSize)
                self.goalPurple.size = CGSize(width: 210, height: self.goalPurple.size.height - increase)
                if self.goalPurple.size.height <= 2 {
                    let gameOverScene = GameOverScene(fileNamed: "GameOverScene")!
                    gameOverScene.scaleMode = .aspectFit
                    self.view?.presentScene(gameOverScene)
                    self.goalPurple.removeAllActions()
                }
            },
            .wait(forDuration: 1)
        ])))
    
        
        goalYellow = SKSpriteNode(color: colors[2], size: .init(width: 210, height: 336))
        goalYellow.position = CGPoint(x: 210, y:-85)
        goalYellow.anchorPoint = .init(x: 0.5, y: 1)
        let centerPointYellow = CGPoint(x: goalYellow.size.width / 2 - (goalYellow.size.width * goalYellow.anchorPoint.x), y:goalYellow.size.height / 2 - (goalYellow.size.height * goalYellow.anchorPoint.y))
        goalYellow.physicsBody = SKPhysicsBody(rectangleOf: goalYellow.size, center: centerPointYellow)
        goalYellow.physicsBody?.isDynamic = false
        goalYellow.name = "color-2-goal"
        goalYellow.zPosition = 3
        addChild(goalYellow)
        

        goalYellow.run(.repeatForever(.sequence([
            .run {
                let increase: CGFloat = CGFloat(self.goalYellow.size.width) / CGFloat(maxSize)
                self.goalYellow.size = CGSize(width: 210, height: self.goalYellow.size.height - increase)
                if self.goalYellow.size.height <= 2 {
                    let gameOverScene = GameOverScene(fileNamed: "GameOverScene")!
                    gameOverScene.scaleMode = .aspectFit
                    self.view?.presentScene(gameOverScene)
                    self.goalBlue.removeAllActions()
                    self.goalYellow.removeAllActions()
                }
            },
            .wait(forDuration: 1)
        ])))
            
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        var colorIndex = 0
        for _ in 1...9 {
            if colorIndex > self.colors.count - 1 {
                colorIndex = 0
            }
            makeBall(at: CGPoint(x: .random(in: -300...300) , y: .random(in: -1...300)), color: colorIndex)
            colorIndex += 1
        }


        let ceiling = SKNode()
                 let ceilingBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width+100, height: 45))
                     ceiling.position = CGPoint(x: 0, y: self.size.height / 2)
                     ceiling.setScale(2)
                     ceiling.name = "ceiling"
                     ceiling.physicsBody = ceilingBody
                     ceiling.physicsBody?.contactTestBitMask = 2
                     ceilingBody.isDynamic = true
                     ceilingBody.pinned = true
                     ceilingBody.allowsRotation = false
                     ceilingBody.contactTestBitMask = ceilingBody.collisionBitMask
                     ceilingBody.categoryBitMask = 2
                     ceilingBody.collisionBitMask = 2
                     addChild(ceiling)
        
        self.physicsWorld.contactDelegate = self
    }

    @objc static override public var supportsSecureCoding: Bool {

        get {
            return true
        }
    }

    func touchDown(atPoint pos : CGPoint) {
        for ball in balls{
              if ball.contains(pos){
                  selectedBall = ball
                  ball.physicsBody?.isDynamic = false
              }
          }
    }

    func touchMoved(toPoint pos : CGPoint) {
        if selectedBall != nil{
            selectedBall.position = pos
        }
    }

    func touchUp(atPoint pos : CGPoint) {
        if selectedBall != nil{
            selectedBall.physicsBody?.isDynamic = true
            selectedBall.physicsBody?.applyImpulse(.init(dx: 600, dy: 600))
        }
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
    
    func collisionBetween(ball: SKNode, object: SKNode, selectedBall: SKShapeNode) {
        let separationObject: [String] = (object.name?.components(separatedBy: "-"))!
        let colorNumberObject: String = separationObject[1]
        let separationBall: [String] = (ball.name?.components(separatedBy: "-"))!
        let colorNumberBall: String = separationBall[1]
        
        
        if colorNumberBall == colorNumberObject{
            makeBall(at: CGPoint(x: .random(in: -300...300) , y: .random(in: -1...300)), color: Int(colorNumberBall) ?? 0)
            destroy(ball: ball)
            
            if let index = balls.firstIndex(of: ball as! SKShapeNode) {
                balls.remove(at: index)
            }
            if colorNumberBall == "0"{
                moviment(goal: goalBlue, valor: 40)
                moviment(goal: goalYellow, valor: 5)
                moviment(goal: goalPurple, valor: -10)
            }
            if colorNumberBall == "1"{
                moviment(goal: goalBlue, valor: -30)
                moviment(goal: goalYellow, valor: -45)
                moviment(goal: goalPurple, valor: 30)
            }
            if colorNumberBall == "2"{
                moviment(goal: goalBlue, valor: -45)
                moviment(goal: goalYellow, valor: 30)
                moviment(goal: goalPurple, valor: -50)
            }
        }

    }
    
    func moviment (goal: SKSpriteNode, valor: CGFloat){
        goal.size = CGSize(width: 210, height: goal.size.height + valor)
    }

    func destroy(ball: SKNode) {
        ball.removeFromParent()
    }

    override public func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    public func didBegin(_ contact: SKPhysicsContact) {
        if self.selectedBall == nil {
            return
        }
        
        let isColor: Bool = contact.bodyA.node?.name?.starts(with: "color-") == true && contact.bodyB.node?.name?.starts(with: "color-") == true
        let isBallAndGoal: Bool = (contact.bodyA.node?.name?.hasSuffix("ball") == true && contact.bodyB.node?.name?.hasSuffix("goal") == true) || (contact.bodyA.node?.name?.hasSuffix("goal") == true && contact.bodyB.node?.name?.hasSuffix("ball") == true)
        if isColor && isBallAndGoal {
            var ball: SKNode!
            var goal: SKNode!
            if contact.bodyA.node?.name?.hasSuffix("ball") == true {
                ball = contact.bodyA.node
                goal = contact.bodyB.node
            } else {
                ball = contact.bodyB.node
                goal = contact.bodyA.node
            }
            if ball != self.selectedBall {
                self.selectedBall = nil
                return
            }
            collisionBetween(ball: ball, object: goal, selectedBall: self.selectedBall)
            self.selectedBall = nil
        }
    }
}



