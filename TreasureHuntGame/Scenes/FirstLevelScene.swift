//
//  FirstLevelScene.swift
//  TreasureHuntGame
//
//  Created by Priskilla Adriani on 20/05/23.
//

import SpriteKit
import GameplayKit

class FirstLevelScene: SKScene, SKPhysicsContactDelegate {
    
    var person = SKSpriteNode()
    var highlight = SKSpriteNode()
    var treasure = SKSpriteNode()
    var bomb = SKSpriteNode()
    var actionButton = SKSpriteNode()
    var zonkArray = [SKSpriteNode]()
    var ray: SKPhysicsBody!
    var sandArray = [SKSpriteNode]()
    
    var lastRayPos = CGPoint(x: 0, y: 0)
    var treasurePos = CGPoint(x: 0, y: 0)
    var bombPos = CGPoint(x: 0, y: 0)
    
    var herMovesLeft = false
    var herMovesRight = false
    var herMovesUp = false
    var herMovesDown = false
    
    enum bitMask: UInt32 {
        case person = 0x1
        case sand = 0x5
        case highlight = 0x3
        case wall = 0x2
        case raycast = 0x4
    }
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        
        for node in self.children {
            if (node.name == "wall"){
                if let someTileMap: SKTileMapNode = node as? SKTileMapNode {
                    giveTileMapPhysicsBody(map: someTileMap)

                    someTileMap.removeFromParent()
                }
            }
            
            if (node.name == "sand") {
                if let someTileMap: SKTileMapNode = node as? SKTileMapNode {
                    giveTileMapPhysicsBody(map: someTileMap)
                    
                    someTileMap.removeFromParent()
                }
                break
            }
        }
        
        addPerson()
        addHighlight()
        addObject()
        actionButton = childNode(withName: "actionButton") as! SKSpriteNode
    }
    
    func addObject() {
        treasurePos = randomPos()
        bombPos = randomPos()
        
        bomb = childNode(withName: "bomb") as! SKSpriteNode
        bomb.position = bombPos
        bomb.isHidden = true
        
        treasure = childNode(withName: "treasure") as! SKSpriteNode
        treasure.position = treasurePos
        treasure.isHidden = true
        
        let zonkTexture = SKTexture(imageNamed: "Zonk")
        for i in 0..<7 {
            let zonk = SKSpriteNode(texture: zonkTexture)
            zonk.position = sandArray[i].position
            zonk.name = "zonk" + String(i)
            zonk.zPosition = 6
            zonk.size = CGSize(width: 80, height: 80)
            zonk.isHidden = true
            zonkArray.append(zonk)
            addChild(zonk)
        }
    }
    
    func randomPos() -> CGPoint {
        guard let index = sandArray.indices.randomElement() else {
            return .zero
            }
            defer { sandArray.remove(at: index) }
        return sandArray[index].position
    }
    
    func addPerson() {
        person = childNode(withName: "Person") as! SKSpriteNode
        
        person.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 80, height: 80))
        person.physicsBody?.categoryBitMask = bitMask.person.rawValue
        person.physicsBody?.contactTestBitMask = bitMask.sand.rawValue
        person.physicsBody?.collisionBitMask = bitMask.wall.rawValue
        person.physicsBody?.allowsRotation = false
        person.physicsBody?.affectedByGravity = false
        
        lastRayPos = CGPoint(x: person.position.x + 70, y: person.position.y)
    }
    
    func giveTileMapPhysicsBody(map: SKTileMapNode) {
        let tileMap = map
        let startLocation: CGPoint = tileMap.position
        let tileSize = tileMap.tileSize
        let halfWidth = CGFloat(tileMap.numberOfColumns) / 2.0 * tileSize.width
        let halfHeight = CGFloat(tileMap.numberOfRows) / 2.0 * tileSize.height
        
        for col in 0..<tileMap.numberOfColumns {
            for row in 0..<tileMap.numberOfRows {
                
                if let tileDefinition = tileMap.tileDefinition(atColumn: col, row: row) {
                    
                    let tileArray = tileDefinition.textures
                    let tileTextures = tileArray[0]
                    let x = CGFloat(col) * tileSize.width - halfWidth + ( tileSize.width / 2 )
                    let y = CGFloat(row) * tileSize.height - halfHeight + ( tileSize.height / 2 )
                    
                    let tileNode = SKSpriteNode(texture: tileTextures)
                    tileNode.position = CGPoint(x: x, y: y)
                    tileNode.size = CGSize(width: 80, height: 80)
                    tileNode.physicsBody = SKPhysicsBody(texture: tileTextures, size: CGSize(width: 80, height: 80))
                    
                    if tileMap.name == "wall" {
                        tileNode.physicsBody?.categoryBitMask = bitMask.wall.rawValue
                        tileNode.physicsBody?.contactTestBitMask = 0
                        tileNode.physicsBody?.collisionBitMask = bitMask.person.rawValue
                    }
                    else if tileMap.name == "sand" {
                        tileNode.physicsBody?.categoryBitMask = bitMask.sand.rawValue
                        tileNode.physicsBody?.contactTestBitMask = bitMask.raycast.rawValue
                        tileNode.physicsBody?.collisionBitMask = 0
                        sandArray.append(tileNode)
                    }
                    
                    tileNode.physicsBody?.affectedByGravity = false
                    tileNode.physicsBody?.isDynamic = false
                    tileNode.physicsBody?.friction = 1
                    tileNode.zPosition = 5
                    
                    tileNode.position = CGPoint(x: tileNode.position.x + startLocation.x, y: tileNode.position.y + startLocation.y)
                    self.addChild(tileNode)
                }
            }
        }
    }
    
    func addHighlight() {
        highlight = childNode(withName: "highlited") as! SKSpriteNode
        highlight.position = lastRayPos
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let position = touch.location(in: self)
            let touchNode = self.nodes(at: position)
            
            for node in touchNode {
                if node.name == "buttonLeft" {
                    herMovesLeft = true
                }
                
                if node.name == "buttonRight" {
                    herMovesRight = true
                }
                
                if node.name == "buttonUp" {
                    herMovesUp = true
                }
                
                if node.name == "buttonDown" {
                    herMovesDown = true
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let position = touch.location(in: self)
            let touchNode = self.nodes(at: position)
            
            for node in touchNode {
                if node.name == "buttonLeft" {
                    herMovesLeft = false
                }
                
                if node.name == "buttonRight" {
                    herMovesRight = false
                }
                
                if node.name == "buttonUp" {
                    herMovesUp = false
                }
                
                if node.name == "buttonDown" {
                    herMovesDown = false
                }
                
                if actionButton.contains(position) {
                    let highlightPosition = CGPoint(x: round(highlight.position.x * 10) / 10.0, y: round(highlight.position.y * 10) / 10.0 )
                    let bombPosition = CGPoint(x: round(bombPos.x * 10) / 10.0, y: round(bombPos.y * 10) / 10.0)
                    let treasurePosition = CGPoint(x: round(treasurePos.x * 10) / 10.0, y: round(treasurePos.y * 10) / 10.0)
                    
                    if highlightPosition == treasurePosition {
                        treasure.isHidden = false
                    }
                    
                    else if highlightPosition == bombPosition {
                        bomb.isHidden = false
                        run(SKAction.sequence([
                            SKAction.wait(forDuration: 1.0),
                            SKAction.run() { [weak self] in
                                guard let `self` = self else { return }
                                let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
                                let scene = GameScene(fileNamed: "GameScene")
                                scene!.size = view!.bounds.size
                                scene!.scaleMode = .aspectFill
                                self.view?.presentScene(scene!, transition:reveal)
                            }
                        ]))
                    }
                    
                    else {
                        for i in 0..<7 {
                            let zonkPosition = CGPoint(x: round(zonkArray[i].position.x * 10) / 10.0, y: round(zonkArray[i].position.y * 10) / 10.0)
                            
                            if highlightPosition == zonkPosition {
                                zonkArray[i].isHidden = false
                                break
                            }
                        }
                    }
                }
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        var xDirection = 0.0
        var yDirection = 0.0
        
        if herMovesRight == true {
            person.position.x += 5
            xDirection = 1
        }
        
        if herMovesLeft == true {
            person.position.x -= 5
            xDirection = -1
        }
        
        if herMovesUp == true {
            person.position.y += 5
            yDirection = 1
        }
        
        if herMovesDown == true {
            person.position.y -= 5
            yDirection = -1
        }
        
        let lastPos = (xDirection == 0 && yDirection == 0) ? lastRayPos : person.position
        let rayPos = CGPoint(x: lastPos.x + xDirection * 70, y: lastPos.y + yDirection * 70)
        
        ray = SKPhysicsBody(circleOfRadius: 10, center: rayPos)
        ray.categoryBitMask = bitMask.raycast.rawValue
        ray.contactTestBitMask = bitMask.sand.rawValue
        ray.collisionBitMask = 0
        physicsBody = ray
        lastRayPos = rayPos
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
