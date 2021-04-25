/*:
 ![Welcome to Equilibrium](welcome2.png)
  
 ## The game of life
 
 Press **start** and challenge yourself to find the equilibrium in an environment that is not always easy or fair (that reminds you of something, right?)

 To do this, drag the balls into the tanks of their respective colors balancing the heights **for 1 minute**.
 
  ---
  
  - Note: For better experience use this Playground in vertical full screen.
  
  */

//#-hidden-code
//Um pouco de código escondido (só funciona no iPad)

import PlaygroundSupport
import SpriteKit
import UIKit
import BookCore
import AVFoundation

let sceneView = SKView(frame: CGRect(x: 0, y: 0, width: 630, height: 886))


if let scene = InitialScene(fileNamed: "InitialScene") {
    scene.scaleMode = .aspectFit
    sceneView.presentScene(scene)
}

PlaygroundPage.current.liveView = sceneView
PlaygroundPage.current.needsIndefiniteExecution = true

//#-end-hidden-code



