//
//  PhysicsDelegate.swift
//  TreasureHuntGame
//
//  Created by Priskilla Adriani on 23/05/23.
//

import GameKit

class ContactManager: SKScene, SKPhysicsContactDelegate {
    
    var highlight: SKSpriteNode
    
    init(highlight: SKSpriteNode) {
        self.highlight = highlight
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    enum bitMask: UInt32 {
        case person = 0x1
        case sand = 0x5
        case highlight = 0x3
        case wall = 0x2
        case raycast = 0x4
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let bitmaskA = contact.bodyA.categoryBitMask
        let bitmaskB = contact.bodyB.categoryBitMask
        
        if (bitmaskA == bitMask.raycast.rawValue && bitmaskB == bitMask.sand.rawValue) {
            highlight.position = contact.bodyB.node!.position
            
        } else if (bitmaskA == bitMask.sand.rawValue && bitmaskB == bitMask.raycast.rawValue) {
            highlight.position = contact.bodyA.node!.position
        }
    }
}
