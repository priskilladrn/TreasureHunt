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
            SKAction.wait(forDuration: 3.0),
            SKAction.run() { [weak self] in
                guard let `self` = self else { return }
                let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
                let scene = FirstLevelScene(fileNamed: "FirstLevelScene")
                scene?.scaleMode = .aspectFill
                self.view?.presentScene(scene!, transition:reveal)
            }
        ]))
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
