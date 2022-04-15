//
//  GameScene.swift
//  ColorSwitch
//
//  Created by Nilesh Kumar on 19/12/21.
//

import SpriteKit
import GameplayKit

enum playColors {
    
    static let colors = [
        UIColor(red: 231/255, green: 76/255, blue: 60/255, alpha: 1.0),
        UIColor(red: 241/255, green: 196/255, blue: 15/255, alpha: 1.0),
        UIColor(red: 46/255, green: 204/255, blue: 113/255, alpha: 1.0),
        UIColor(red: 52/255, green: 152/255, blue: 219/255, alpha: 1.0)
    ]
    
}

enum SwitchState: Int {
    case red, yellow, green, blue
}


class GameScene: SKScene {

    var colorSwitch: SKSpriteNode!
    var switchState = SwitchState.red
    var ball: SKSpriteNode!
    var colorIndex: Int?
    
    let scoreLabel = SKLabelNode(text: "0")
    
    var score = 0
    
    override func didMove(to view: SKView) {

        setupPhysics()
        layout()
    }
    
    func setupPhysics(){
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -1.0)
        physicsWorld.contactDelegate = self
    }
        
    func layout(){
        backgroundColor = UIColor(red: 44/255, green: 62/255, blue: 80/255, alpha: 1.0)
        colorSwitch = SKSpriteNode(imageNamed: "ColorCircle")
        colorSwitch.size = CGSize(width: frame.size.width/3, height: frame.size.width/3)
        colorSwitch.zPosition = zPositions.colorSwitch
        colorSwitch.position = CGPoint(x: frame.midX, y: frame.minY + colorSwitch.frame.height)
        colorSwitch.physicsBody = SKPhysicsBody(circleOfRadius: colorSwitch.size.width / 2)
        colorSwitch.physicsBody?.categoryBitMask = physicsCategories.switchCategory
        colorSwitch.physicsBody?.isDynamic = false
        addChild(colorSwitch)
        
        scoreLabel.fontName = "AvenirNext-Bold" //AvenirNext
        scoreLabel.fontColor = UIColor.white
        scoreLabel.fontSize = 60.0
        scoreLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        scoreLabel.zPosition = zPositions.label
        addChild(scoreLabel)
        
        ballLayout()
    }
    
    func ballLayout(){

        colorIndex = Int(arc4random_uniform(4))
        
        ball = SKSpriteNode(texture: SKTexture(imageNamed: "ball"), color: playColors.colors[colorIndex!], size: CGSize(width: 30.0, height: 30.0))
        ball.colorBlendFactor = 1
        ball.name = "Ball"
        ball.position = CGPoint(x: frame.midX, y: frame.midY + (ball.frame.height * 18))
        ball.zPosition = zPositions.ball
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2)
        ball.physicsBody?.categoryBitMask = physicsCategories.ballCategory
        ball.physicsBody?.contactTestBitMask = physicsCategories.switchCategory
        ball.physicsBody?.collisionBitMask = physicsCategories.none
        addChild(ball)
        

        
    }
    
    func updateScoreLabel(){
        
        scoreLabel.text = "\(score)"
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        turnWheel()
    }
    
    func turnWheel(){
        
        if let newState = SwitchState(rawValue: switchState.rawValue + 1){
            switchState = newState
        } else {
            switchState = .red
        }
        
        colorSwitch.run(SKAction.rotate(byAngle: .pi/2, duration: 0.25))
        
    }
    
    func gameOver(){
       
        UserDefaults.standard.setValue(score, forKey: "Recent Score")
        if score > UserDefaults.standard.integer(forKey: "HighScore"){
            UserDefaults.standard.setValue(score, forKey: "HighScore")
        }
        let menuScene = MenuScene(size: view!.bounds.size)
        view!.presentScene(menuScene)
        
        
    }
    
}


extension GameScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        if contactMask == physicsCategories.ballCategory | physicsCategories.switchCategory {
            if let ball = contact.bodyA.node?.name == "Ball" ? contact.bodyA.node as? SKSpriteNode : contact.bodyB.node as? SKSpriteNode {
                if colorIndex == switchState.rawValue {
                    run(SKAction.playSoundFileNamed("bling", waitForCompletion: false))
                    self.score += 1
                    updateScoreLabel()
                    ball.run(SKAction.fadeOut(withDuration: 0.25), completion: {
                        ball.removeFromParent()
                        self.ballLayout()
                    })
                } else {
                    run(SKAction.playSoundFileNamed("mixkit-player", waitForCompletion: false))
                    gameOver()
                }
            }
        }
    }
    
}
