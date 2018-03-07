//
//  Level.swift
//  Space Invaders AR
//
//  Created by Francesco Chiusolo on 27/02/2018.
//  Copyright © 2018 Francesco Chiusolo. All rights reserved.
//

import SceneKit

protocol PlayerDelegate {
    var position: SCNVector3 { get }
    var orientation: SCNVector3 { get }
}

class Level: SCNScene {
    
    // MARK: - Properties
    
    var lastSpawnTime: TimeInterval?
    
    var playerDelegate: PlayerDelegate?
    
    let playerScore: PlayerScore
    
    var enemies: [Enemy] = []
    
    // MARK: - Initializers
    
    init(playerScore: PlayerScore) {
        self.playerScore = playerScore
        super.init()
        physicsWorld.contactDelegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Method init?(coder:) not implemented")
    }
    
    // MARK: - Gameplay
    
    func update(updateAtTime time: TimeInterval) {
        guard let lastSpawnTime = self.lastSpawnTime else {
            // At the first update, lastSpawnTime is nil; init it with time.
            self.lastSpawnTime = time
            return
        }
        
        let deltaTime = time - lastSpawnTime
        if deltaTime >= Constants.Time.enemySpawnInterval.rawValue {
            self.lastSpawnTime = time
            
            let enemy = Enemy.spawn(in: self, whenPlayerIsAt: self.playerDelegate?.position ?? SCNVector3Zero)
            enemies.append(enemy)
        }
        
        for enemy in enemies {
            enemy.update(deltaTime: deltaTime)
        }
    }
    
    func tap() {
        guard let playerDelegate = playerDelegate else {
            fatalError("Level need to know where the user is to shoot a bullet")
        }
        
        let bullet = Bullet.build(in: self, at: playerDelegate.position)
        bullet.shoot(toward: playerDelegate.orientation)
    }
    
}

// MARK: - SCNPhysicsContactDelegate

extension Level: SCNPhysicsContactDelegate {
    
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        // Check which of the two nodes is an enemy
        let nodeA = contact.nodeA
        let nodeB = contact.nodeB
        var enemy: SCNNode?
        var bullet: SCNNode?
        if nodeA.physicsBody?.categoryBitMask == BitMaskCategory.enemy.rawValue {
            enemy = nodeA
            bullet = nodeB
        } else if nodeB.physicsBody?.categoryBitMask == BitMaskCategory.enemy.rawValue {
            enemy = nodeB
            bullet = nodeA
        }
        
        // Load the explosion particle system
        if let enemy = enemy as? Enemy, let bullet = bullet as? Bullet {
            let killed = enemy.hit(by: bullet, in: self, at: contact.contactPoint)
            if killed {
                playerScore.score += enemy.score
            }
        }
    }
    
}
