//
//  PersonNode.swift
//  TreasureHuntGame
//
//  Created by Priskilla Adriani on 24/05/23.
//

import SpriteKit

class Person: SKSpriteNode {
    
    
//    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
//        super.init(texture: texture, color: color, size: size)
//
//        physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 80, height: 80))
//        physicsBody?.categoryBitMask = bitMask.person.rawValue
//        physicsBody?.contactTestBitMask = bitMask.sand.rawValue
//        physicsBody?.collisionBitMask = bitMask.wall.rawValue
//        physicsBody?.allowsRotation = false
//        physicsBody?.affectedByGravity = false
//    }
//
////    convenience init(imageNamed name: String) {
////        let texture = SKTexture(imageNamed: name)
////        self.init(texture: texture, color: .white, size: texture.size())
////    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("error")
//    }
    
    func setup() {
        physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 80, height: 80))
        physicsBody?.categoryBitMask = bitMask.person.rawValue
        physicsBody?.contactTestBitMask = bitMask.sand.rawValue
        physicsBody?.collisionBitMask = bitMask.wall.rawValue
        physicsBody?.allowsRotation = false
        physicsBody?.affectedByGravity = false
    }
}
