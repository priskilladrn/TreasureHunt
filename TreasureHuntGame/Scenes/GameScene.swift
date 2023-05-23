//
//  GameScene.swift
//  TreasureHuntGame
//
//  Created by Priskilla Adriani on 19/05/23.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var button = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        setupNodes()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if button.contains(location) {
                let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
                let levelScene = LevelScene(size: self.size, level: 2)
                view?.presentScene(levelScene, transition: reveal)
            }
        }
    }
}

extension GameScene {
    func setupNodes() {
        createButton()
    }
    
    func createButton() {
        button = childNode(withName: "btnPlay") as! SKSpriteNode
        button.zPosition = 10
    }
}
