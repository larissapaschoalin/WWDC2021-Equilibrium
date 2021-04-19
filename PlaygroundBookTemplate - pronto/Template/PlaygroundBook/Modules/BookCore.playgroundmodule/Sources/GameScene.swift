import SpriteKit
import AVFoundation

public class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var colors: [UIColor] = []
    var balls = [SKShapeNode]()
    var selectedBall: SKShapeNode!
    var goalBlue: SKSpriteNode!
    var goalYellow: SKSpriteNode!
    var goalPurple: SKSpriteNode!
    let backgroud = SKSpriteNode(imageNamed: "background")
    var timeBarStroke: SKShapeNode!
    var goalStrokeBlue: SKShapeNode!
    var goalStrokeYellow: SKShapeNode!
    var goalStrokePurple: SKShapeNode!
    var timeBar: SKSpriteNode!
    var teste: CGFloat = 0
    var lastTime: TimeInterval = 0
    var speedGoal: CGFloat = 12
    var speedIncrease: CGFloat = 200
    var speedDecreaseFast: CGFloat = 40
    var goalBlueDecreasing = true
    var goalYellowDecreasing = true
    var goalPurpleDecreasing = true
    var timeBlue: TimeInterval = 0
    var timeYellow: TimeInterval = 0
    var timePurple: TimeInterval = 0
    var goalBlueFastDecrease = false
    var goalYellowFastDecrease = false
    var goalPurpleFastDecrease = false
    var audioPlayer: AVAudioPlayer = AVAudioPlayer()
    
    func playSound(nameSound: String) {
        do {
            guard let path = Bundle.main.path(forResource: nameSound, ofType: "mp3") else { return }
            let url = URL(fileURLWithPath: path)
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.prepareToPlay()
            audioPlayer.play()
            audioPlayer.volume = 0.3
            
        } catch {
            return
        }
    }


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
        ball.strokeColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        ball.name = "color-\(color)-ball"
        self.addChild(ball)
        balls.append(ball)
        setupPhysics(ball: ball)
    }
    
    func setupPhysics(ball: SKShapeNode){
        ball.physicsBody = SKPhysicsBody(circleOfRadius: 20)
        ball.physicsBody?.isDynamic = true
        ball.physicsBody?.affectedByGravity = false
        ball.physicsBody?.allowsRotation = true
        ball.physicsBody?.restitution = 1.1
        ball.physicsBody?.collisionBitMask = 2
        ball.physicsBody?.mass = 2
        ball.physicsBody?.contactTestBitMask = ball.physicsBody!.collisionBitMask
        ball.physicsBody?.applyImpulse(.init(dx: 900, dy: 900))
    
    }
    

    override public func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        
        backgroud.position.x = self.frame.midX
        backgroud.position.y = self.frame.midY
        backgroud.setScale(0.35)

        addChild(backgroud)
    
        
        let xRed = UIColor(red: 231/255, green: 95/255, blue: 93/255, alpha: 1.0)
        timeBar = SKSpriteNode(color: xRed, size: .init(width: self.size.width, height: 50))
        timeBar.position = CGPoint(x: self.size.width / -2, y: self.size.height / 2)
        timeBar.anchorPoint = .init(x: 0, y: 0.5)
        timeBar.zPosition = 2
        addChild(timeBar)
        
        timeBar.run(.scaleX(to: 0, duration: 60)){
            let winScene = WinScene(fileNamed: "WinScene")!
            winScene.scaleMode = .aspectFit
            self.view?.presentScene(winScene)
        }


        goalBlue = SKSpriteNode(color: colors[0], size: .init(width: 210, height: 372))
        goalBlue.position = CGPoint(x: -210, y:-78)
        goalBlue.anchorPoint = .init(x: 0.5, y: 1)
        let centerPointBlue = CGPoint(x: goalBlue.size.width / 2 - (goalBlue.size.width * goalBlue.anchorPoint.x), y:goalBlue.size.height / 2 - (goalBlue.size.height * goalBlue.anchorPoint.y))
        goalBlue.physicsBody = SKPhysicsBody(rectangleOf: goalBlue.size, center: centerPointBlue)
        goalBlue.physicsBody?.isDynamic = false
        goalBlue.name = "color-0-goal"
        goalBlue.zPosition = 3
        addChild(goalBlue)
        

        goalPurple = SKSpriteNode(color: colors[1], size: .init(width: 210, height: 372))
        goalPurple.position = CGPoint(x: 0, y:-78)
        goalPurple.anchorPoint = .init(x: 0.5, y: 1)
        let centerPointPurple = CGPoint(x: goalPurple.size.width / 2 - (goalPurple.size.width * goalPurple.anchorPoint.x), y:goalPurple.size.height / 2 - (goalPurple.size.height * goalPurple.anchorPoint.y))
        goalPurple.physicsBody = SKPhysicsBody(rectangleOf: goalPurple.size, center: centerPointPurple)
        goalPurple.physicsBody?.isDynamic = false
        goalPurple.physicsBody!.collisionBitMask = 2
        goalPurple.physicsBody?.contactTestBitMask = goalPurple.physicsBody!.collisionBitMask
        goalPurple.name = "color-1-goal"
        goalPurple.zPosition = 3
        addChild(goalPurple)
        
        
        goalYellow = SKSpriteNode(color: colors[2], size: .init(width: 210, height: 372))
        goalYellow.position = CGPoint(x: 210, y:-78)
        goalYellow.anchorPoint = .init(x: 0.5, y: 1)
        let centerPointYellow = CGPoint(x: goalYellow.size.width / 2 - (goalYellow.size.width * goalYellow.anchorPoint.x), y:goalYellow.size.height / 2 - (goalYellow.size.height * goalYellow.anchorPoint.y))
        goalYellow.physicsBody = SKPhysicsBody(rectangleOf: goalYellow.size, center: centerPointYellow)
        goalYellow.physicsBody?.isDynamic = false
        goalYellow.name = "color-2-goal"
        goalYellow.zPosition = 3
        addChild(goalYellow)
        
        
        goalStrokeBlue = SKShapeNode(rect: goalBlue.frame)
        goalStrokeBlue.strokeColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        goalStrokeBlue.fillColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        goalStrokeBlue.name = "color-0-goal"
        addChild(goalStrokeBlue)
        
        goalStrokeYellow = SKShapeNode(rect: goalYellow.frame)
        goalStrokeYellow.strokeColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        goalStrokeYellow.fillColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        goalStrokeYellow.name = "color-2-goal"
        addChild(goalStrokeYellow)
        
        goalStrokePurple = SKShapeNode(rect: goalPurple.frame)
        goalStrokePurple.strokeColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        goalStrokePurple.fillColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        goalStrokePurple.name = "color-1-goal"
        addChild(goalStrokePurple)
        
        timeBarStroke = SKShapeNode(rect: timeBar.frame)
        timeBarStroke.strokeColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        timeBarStroke.fillColor = #colorLiteral(red: 0.9293201566, green: 0.9294758439, blue: 0.9292996526, alpha: 1)
        timeBarStroke.zPosition = 1
        addChild(timeBarStroke)
            
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        var colorIndex = 0
        for _ in 1...6 {
            if colorIndex > self.colors.count - 1 {
                colorIndex = 0
            }
            makeBall(at: CGPoint(x: .random(in: -300...300) , y: .random(in: -1...300)), color: colorIndex)
            colorIndex += 1
        }
        makeBall(at: CGPoint(x: .random(in: -300...300) , y: .random(in: -1...300)), color: 2)
        makeBall(at: CGPoint(x: .random(in: -300...300) , y: .random(in: -1...300)), color: 2)
        makeBall(at: CGPoint(x: .random(in: -300...300) , y: .random(in: -1...300)), color: 2)
        makeBall(at: CGPoint(x: .random(in: -300...300) , y: .random(in: -1...300)), color: 2)
        makeBall(at: CGPoint(x: .random(in: -300...300) , y: .random(in: -1...300)), color: 2)


        let ceiling = SKNode()
                 let ceilingBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width+100, height: 65))
                     ceiling.position = CGPoint(x: 0, y: self.size.height / 2)
                     ceiling.setScale(2)
                     ceiling.name = "ceiling"
                     ceiling.physicsBody = ceilingBody
                     ceiling.physicsBody?.contactTestBitMask = 2
                     ceilingBody.isDynamic = false
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
                  ball.physicsBody = nil
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
            setupPhysics(ball: selectedBall)
            if goalStrokeBlue.contains(pos){
                collisionBetween(ball: selectedBall, object: goalStrokeBlue, selectedBall: selectedBall)
            } else if goalStrokeYellow.contains(pos){
                collisionBetween(ball: selectedBall, object: goalStrokeYellow, selectedBall: selectedBall)
            } else if goalStrokePurple.contains(pos){
                collisionBetween(ball: selectedBall, object: goalStrokePurple, selectedBall: selectedBall)
            }
            selectedBall = nil
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
    
    func collisionBetween(ball: SKNode, object: SKShapeNode, selectedBall: SKShapeNode) {
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
                playSound(nameSound: "acerto")
                goalBlueDecreasing = false
                goalYellowFastDecrease = true
                goalPurpleFastDecrease = true
            }
            if colorNumberBall == "1"{
                playSound(nameSound: "acerto")
                goalPurpleDecreasing = false
                goalYellowFastDecrease = true
                goalBlueFastDecrease = true
            }
            if colorNumberBall == "2"{
                playSound(nameSound: "acerto")
                goalYellowDecreasing = false
                goalBlueFastDecrease = true
                goalPurpleFastDecrease = true
            }
        } else {
            playSound(nameSound: "erro")
            ball.position = CGPoint(x: .random(in: -300...300) , y: .random(in: -1...300))
        }

    }
    

    func destroy(ball: SKNode) {
        ball.removeFromParent()
    }

    override public func update(_ currentTime: TimeInterval) {
        if lastTime == 0 {
            lastTime = currentTime
            return
        }
        let deltaTime = currentTime - lastTime
        lastTime = currentTime
        let decrease = speedGoal * CGFloat(deltaTime)
        let increase = speedIncrease * CGFloat(deltaTime)
        let decreaseFast = speedDecreaseFast * CGFloat(deltaTime)
        
        if goalPurpleFastDecrease {
            goalDecrease(decrease: decreaseFast, goal: goalPurple)
            timePurple += deltaTime
            if timePurple >= 0.3 {
                goalPurpleFastDecrease = false
                timePurple = 0
            }
        } else if goalPurpleDecreasing {
            goalDecrease(decrease: decrease, goal: goalPurple)
        } else {
            goalIncrease(increase: increase, goal: goalPurple)
            timePurple += deltaTime
            if timePurple >= 0.3 {
                goalPurpleDecreasing = true
                timePurple = 0
            }
        }
        
        if goalBlueFastDecrease {
            goalDecrease(decrease: decreaseFast, goal: goalBlue)
            timeBlue += deltaTime
            if timeBlue >= 0.3 {
                goalBlueFastDecrease = false
                timeBlue = 0
            }
        } else if goalBlueDecreasing {
            goalDecrease(decrease: decrease, goal: goalBlue)
        } else {
            goalIncrease(increase: increase, goal: goalBlue)
            timeBlue += deltaTime
            if timeBlue >= 0.3 {
                goalBlueDecreasing = true
                timeBlue = 0
            }
        }
        
        if goalYellowFastDecrease {
            goalDecrease(decrease: decreaseFast, goal: goalYellow)
            timeYellow += deltaTime
            if timeYellow >= 0.3 {
                goalYellowFastDecrease = false
                timeYellow = 0
            }
        } else if goalYellowDecreasing {
            goalDecrease(decrease: decrease, goal: goalYellow)
        } else {
            goalIncrease(increase: increase, goal: goalYellow)
            timeYellow += deltaTime
            if timeYellow >= 0.3 {
                goalYellowDecreasing = true
                timeYellow = 0
            }
        }
    }
    
    public func didBegin(_ contact: SKPhysicsContact) {

    }
    
    func goalIncrease(increase: CGFloat, goal: SKSpriteNode){
        let height = goal.size.height + increase
        goal.size = CGSize(width: 210, height: height)
    }
    
    func goalDecrease(decrease: CGFloat, goal: SKSpriteNode){
        var height = goal.size.height - decrease
        if height <= 0 {
            height = 0
            gameOver()
        }
        goal.size = CGSize(width: 210, height: height)
    }
    
    func gameOver(){
        let gameOverScene = GameOverScene(fileNamed: "GameOverScene")!
        gameOverScene.scaleMode = .aspectFit
        self.view?.presentScene(gameOverScene)
    }
}



