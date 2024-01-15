//
//  CreditScene.swift
//  TreasureHuntGame
//
//  Created by Priskilla Adriani on 20/05/23.
//

import SpriteKit

class CreditScene: SKScene {
    init(size: CGSize, titleName: String) {
        super.init(size: size)
        
        let font: String = "PixelGameFont"
        
        backgroundColor = UIColor(named: "Brown")!
        
        let title = SKLabelNode(fontNamed: font)
        title.text = titleName
        title.fontSize = 60
        title.fontColor = UIColor(named: "Cream")!
        title.position = CGPoint(x: size.width/2, y: size.height/2)
        addChild(title)
//        
//        let sound = SKLabelNode(fontNamed: font)
//        sound.text = "SOUND EFFECT: Pixabay"
//        sound.fontSize = 14
//        sound.fontColor = UIColor(named: "Cream")!
//        sound.position = CGPoint(x: size.width/2, y: size.height * 0.45)
//        addChild(sound)
//        
//        let asset = SKLabelNode(fontNamed: font)
//        asset.text = "VISUAL ASSET: Kenney"
//        asset.fontSize = 14
//        asset.fontColor = UIColor(named: "Cream")!
//        asset.position = CGPoint(x: size.width/2, y: size.height * 0.35)
//        addChild(asset)
//        
//        let music = SKLabelNode(fontNamed: font)
//        music.text = "MUSIC: Crystal Caverns By HeatleyBros"
//        music.fontSize = 14
//        music.fontColor = UIColor(named: "Cream")!
//        music.position = CGPoint(x: size.width/2, y: size.height * 0.25)
//        addChild(music)
        
        run(SKAction.sequence([
            SKAction.wait(forDuration: 2.0),
            SKAction.run() { [weak self] in
                guard let `self` = self else { return }
                let reveal = SKTransition.fade(withDuration: 1.0)
                let scene = GameScene(fileNamed: "GameScene")
                scene!.size = view!.bounds.size
                scene!.scaleMode = .aspectFill
                self.view?.presentScene(scene!, transition:reveal)
            }
        ]))
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
