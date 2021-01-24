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
    var lastUpdateTime: TimeInterval = 0
    var dt: TimeInterval = 0
    var velocity = CGPoint.zero
    var lastTouchLocation: CGPoint?
    let zombie = SKSpriteNode(imageNamed: "zombie1")
    let zombieMovePointPerSec: CGFloat = 480.0
    
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
    
    func moveZombieToward(_ location: CGPoint){
        let offset = CGPoint(x: location.x - zombie.position.x, y: location.y - zombie.position.y)
        let lenght = sqrt(Double(offset.x * offset.x + offset.y * offset.y))
        let direction = CGPoint(x: offset.x / CGFloat(lenght), y: offset.y / CGFloat(lenght))
        
        velocity = CGPoint(x: direction.x * zombieMovePointPerSec, y: direction.y * zombieMovePointPerSec)
    }
    
    func moveSprite(_ sprite: SKSpriteNode, velocity: CGPoint) {
        let amoutToMove = CGPoint(x: velocity.x * CGFloat(dt), y: velocity.y * CGFloat(dt))
        print("Amount to move \(amoutToMove)")
        sprite.position = CGPoint(x: sprite.position.x + amoutToMove.x, y: sprite.position.y + amoutToMove.y)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        let touchLocation = touch.location(in: self)
        lastTouchLocation = touchLocation
        moveZombieToward(touchLocation)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        let touchLocation = touch.location(in: self)
        lastTouchLocation = touchLocation
        moveZombieToward(touchLocation)
    }
    
    override func update(_ currentTime: TimeInterval) {
        if lastUpdateTime > 0 {
            dt = currentTime - lastUpdateTime
        } else {
            dt = 0
        }
        lastUpdateTime = currentTime
        print("\(dt*1000) milliseconds since last update")
        
        if let lastTouchLocation = lastTouchLocation {
            let diff = lastTouchLocation - zombie.position
            if (diff.length() <= zombieMovePointPerSec * CGFloat(dt)) {
                zombie.position = lastTouchLocation
                velocity = CGPoint.zero
            } else {
                moveSprite(zombie, velocity: velocity)
            }
        }
    }
}
