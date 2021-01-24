//
//  GameScene.swift
//  ZombieConga
//
//  Created by Bruno Silva on 23/01/21.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    //MARK: - Variables
    let zombie = SKSpriteNode(imageNamed: "zombie1")
    var lastUpdateTime: TimeInterval = 0
    var dt: TimeInterval = 0
    
    //MARK: - Functions
    override func didMove(to view: SKView) {
        
        //MARK: Adding the background
        let background = SKSpriteNode(imageNamed: "background1")
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        background.anchorPoint = CGPoint(x: 0.5, y: 0.5) //default
        background.zPosition = -1
        addChild(background)
        
        //MARK: Adding the Zombie
        zombie.position = CGPoint(x: 550, y: 550)
        addChild(zombie)
    }
}
