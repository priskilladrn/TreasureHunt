//
//  LevelScene.swift
//  TreasureHuntGame
//
//  Created by Priskilla Adriani on 20/05/23.
//

import SpriteKit

class LevelScene: SKScene {
    init(size: CGSize, level: Int) {
        super.init(size: size)
        
        backgroundColor = UIColor(named: "Brown")!
        
        let label = SKLabelNode(fontNamed: "PixelGameFont")
        label.text = "LEVEL  \(level)"
        label.fontSize = 40
        label.fontColor = UIColor(named: "Cream")!
        label.position = CGPoint(x: size.width/2, y: size.height/2)
        addChild(label)
        
        run(SKAction.sequence([
            SKAction.wait(forDuration: 1),
            SKAction.run() { [weak self] in
                guard let `self` = self else { return }
                let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
                switch (level) {
                case 1:
                    let scene = StageScene(fileNamed: "FirstLevelScene")!
                    scene.level = level
                    scene.sandCount = 7
                    scene.scaleMode = .aspectFill
                    self.view?.presentScene(scene, transition:reveal)
                case 2:
                    let scene = StageScene(fileNamed: "SecondLevelScene")!
                    scene.level = level
                    scene.sandCount = 14
                    scene.scaleMode = .aspectFill
                    self.view?.presentScene(scene, transition:reveal)
                case 3:
                    let scene = StageScene(fileNamed: "ThirdLevelScene")!
                    scene.level = level
                    scene.sandCount = 23
                    scene.scaleMode = .aspectFill
                    self.view?.presentScene(scene, transition:reveal)
                default:
                    let scene = GameScene()
                    scene.scaleMode = .aspectFill
                    self.view?.presentScene(scene, transition:reveal)
                }
            }
        ]))
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
