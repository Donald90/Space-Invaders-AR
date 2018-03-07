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
    
    // Last time an Enemy has been spawned
    var lastSpawnTime: TimeInterval?
    
    // Last time the scene has been updated
    var lastUpdateTime: TimeInterval?
    
    // Player delegate from which get informations about player
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
        // If lastSpawnTime and lastUpdateTime are undefined, assign them
        // the update time. This happens only the at the first update so we can skip it.
        guard let lastSpawnTime = self.lastSpawnTime,
            let lastUpdateTime = self.lastUpdateTime else {
                self.lastSpawnTime = time
                self.lastUpdateTime = time
                return
        }
        
        // If playerDelegate is undefined, skip every update.
        guard let playerPosition = playerDelegate?.position else {
            return
        }
        
        // Spawn an enemy every Constants.Time.enemySpawnInterval
        let deltaTime = time - lastSpawnTime
        if deltaTime >= Constants.Time.enemySpawnInterval.rawValue {
            // Update lastSpawnTime to match this current time
            self.lastSpawnTime = time
            
            let enemy = Enemy.spawn(in: self, whenPlayerIsAt: playerPosition)
            enemies.append(enemy)
        }
        
        // Let every enemy follow the player
        for enemy in enemies {
            enemy.follow(player: playerPosition, deltaTime: time - lastUpdateTime)
        }
        
        // Update lastUpdateTime to match this current time
        self.lastUpdateTime = time
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
        // Check which of the two nodes is an enemy and which a bullet
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
        if let enemy = enemy as? Enemy,
            let bullet = bullet as? Bullet {
            let killed = enemy.hit(by: bullet, in: self, at: contact.contactPoint)
            if killed {
                playerScore.score += enemy.score
            }
        }
    }
    
}
