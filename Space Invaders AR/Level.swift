//
//  Level.swift
//  Space Invaders AR
//
//  Created by Francesco Chiusolo on 27/02/2018.
//  Copyright © 2018 Francesco Chiusolo. All rights reserved.
//

import SceneKit

protocol LevelDelegate {
    var playerPosition: SCNVector3 { get }
    var playerOrientation: SCNVector3 { get }
}

class Level: SCNScene {
    
    // MARK: - Properties
    
    static let spawnInterval: TimeInterval = 3
    
    var delegate: LevelDelegate?
    
    let playerScore: PlayerScore
    
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
    
    func run() {
        Timer.scheduledTimer(withTimeInterval: Level.spawnInterval, repeats: true) { (_) in
            _ = Enemy.spawn(for: self, whenPlayerIsAt: self.delegate?.playerPosition ?? SCNVector3Zero)
        }
    }
    
    func tap() {
        guard let delegate = delegate else {
            fatalError("Level need to know where the user is to shoot a bullet")
        }
        
        let bullet = Bullet.build(for: self, at: delegate.playerPosition)
        bullet.shoot(toward: delegate.playerOrientation)
    }
    
}

// MARK: - SCNPhysicsContactDelegate

extension Level: SCNPhysicsContactDelegate {
    
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        // Check which of the two nodes is an enemy
        let nodeA = contact.nodeA
        let nodeB = contact.nodeB
        var enemy: SCNNode?
        if nodeA.physicsBody?.categoryBitMask == BitMaskCategory.enemy.rawValue {
            enemy = nodeA
        } else if nodeB.physicsBody?.categoryBitMask == BitMaskCategory.enemy.rawValue {
            enemy = nodeB
        }
        
        // Load the explosion particle system
        if let enemy = enemy {
            SCNParticleSystem.build(for: self, explode: enemy, at: contact.contactPoint)
            enemy.removeFromParentNode()
            playerScore.score += 1
        }
    }
    
}
