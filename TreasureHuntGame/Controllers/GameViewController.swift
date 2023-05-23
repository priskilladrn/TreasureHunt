//
//  GameViewController.swift
//  TreasureHuntGame
//
//  Created by Priskilla Adriani on 19/05/23.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let scene = GameScene(fileNamed: "GameScene")
        scene!.size = view.bounds.size
        scene!.scaleMode = .aspectFill
        
        let skView = view as! SKView
        skView.ignoresSiblingOrder = true
        skView.presentScene(scene)
        skView.showsPhysics = true
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
