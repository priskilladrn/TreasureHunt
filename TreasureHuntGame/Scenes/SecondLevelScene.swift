//
//  SecondLevelScene.swift
//  TreasureHuntGame
//
//  Created by Priskilla Adriani on 20/05/23.
//

import SpriteKit
import GameplayKit

class SecondLevelScene: SKScene, SKPhysicsContactDelegate {
    
    var person = SKSpriteNode()
    let herTexture = SKTexture(imageNamed: "Person")
    
    enum bitMask: UInt32 {
        case person = 0b1
        case wall = 0b10
    }
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
    }
    
    func addPerson() {
        person = childNode(withName: "Person") as! SKSpriteNode
        
        person.physicsBody = SKPhysicsBody(texture: herTexture, size: person.size)
        person.physicsBody?.categoryBitMask = bitMask.person.rawValue
        person.physicsBody?.contactTestBitMask = bitMask.wall.rawValue
        person.physicsBody?.collisionBitMask = bitMask.wall.rawValue
        person.physicsBody?.allowsRotation = false
    }
}

extension SecondLevelScene {
    
}
