//
//  menu.swift
//  menu
//
//  Created by Nilesh Kumar on 20/12/21.
//

import SpriteKit

class MenuScene: SKScene {

    override func didMove(to view: SKView) {
        backgroundColor = UIColor(red: 44/255, green: 62/255, blue: 80/255, alpha: 1.0)
        addLogo()
        addLabels()
       // run(SKAction.playSoundFileNamed("mixkit-game", waitForCompletion: false))
        
        let action: SKAction = SKAction.playSoundFileNamed("mixkit-game", waitForCompletion: false)
        self.run(action, withKey:"mixkit-game")
        
        
    }
    
    func addLogo() {
        let logo = SKSpriteNode(imageNamed: "logo")
        logo.size = CGSize(width: frame.size.width/4, height: frame.size.width/4)
        logo.position = CGPoint(x: frame.midX, y: frame.midY + frame.size.height/4)
        addChild(logo)
    }
    
    func addLabels() {
        let playLabel = SKLabelNode(text: "Tap to Play!")
        playLabel.fontName = "AvenirNext-Bold"
        playLabel.fontSize = 50.0
        playLabel.fontColor = UIColor.white
        playLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        animate(label: playLabel)
        addChild(playLabel)
        
        let highscoreLabel = SKLabelNode(text: "Highscore:" + " \(UserDefaults.standard.integer(forKey: "HighScore"))")
        highscoreLabel.fontName = "AvenirNext-Bold"
        highscoreLabel.fontSize = 40.0
        highscoreLabel.fontColor = UIColor.white
        highscoreLabel.position = CGPoint(x: frame.midX, y: frame.midY - highscoreLabel.frame.size.height*4)
        addChild(highscoreLabel)
        
        let recentScoreLabel = SKLabelNode(text: "Recent Score:" + " \(UserDefaults.standard.integer(forKey: "Recent Score"))")
        recentScoreLabel.fontName = "AvenirNext-Bold"
        recentScoreLabel.fontSize = 40.0
        recentScoreLabel.fontColor = UIColor.white
        recentScoreLabel.position = CGPoint(x: frame.midX, y: highscoreLabel.position.y - recentScoreLabel.frame.size.height*2)
        addChild(recentScoreLabel)
    }
    
    func animate(label: SKLabelNode){
        
//        let fadeOut = SKAction.fadeOut(withDuration: 0.75)
//        let fadeIn = SKAction.fadeIn(withDuration: 0.75)
        
        let scaleUp = SKAction.scale(to: 1.1, duration: 0.5)
        let scaleDown = SKAction.scale(to: 1.0, duration: 0.5)
        let sequance = SKAction.sequence([scaleUp, scaleDown])
        label.run(SKAction.repeatForever(sequance))
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let gameScene = GameScene(size: view!.bounds.size)
        view!.presentScene(gameScene)
        self.removeAction(forKey: "mixkit-game")
    }
    
}
