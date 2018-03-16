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
    let playerDelegate: PlayerDelegate
    
    let playerScore: PlayerScore
    
    var enemies: [Enemy] = []
    
    var player = Player()
    
    let radar = Radar()
    
    // MARK: - Initializers
    
    init(playerScore: PlayerScore, playerDelegate: PlayerDelegate) {
        self.playerScore = playerScore
        self.playerDelegate = playerDelegate
        super.init()
        physicsWorld.contactDelegate = self
        
        rootNode.addChildNode(player)
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
        
        // Retrieve player position
        let playerPosition = playerDelegate.position
        
        // Spawn an enemy every Constants.Time.enemySpawnInterval
        let deltaSpawnTime = time - lastSpawnTime
        if deltaSpawnTime >= Constants.Time.enemySpawnInterval.rawValue {
            // Update lastSpawnTime to match this current time
            self.lastSpawnTime = time
            
            let enemy = Enemy.spawn(whenPlayerIsAt: playerPosition)
            add(enemy: enemy)
        }
        
        let deltaTime = time - lastUpdateTime
        
        // Let every enemy follow the player
        for enemy in enemies {
            enemy.follow(player: playerPosition, deltaTime: deltaTime)
        }
        
        // Update the radar
        if enemies.count > 0 {
            let direction = radar.update(deltaTime: deltaTime, player: player.position, target: enemies[0].position)
            debugPrint(direction)
        }
        
        // Update lastUpdateTime to match this current time
        self.lastUpdateTime = time
    }
    
    func update(player position: SCNVector3) {
        player.position = position
    }
    
    func tap() {
        // Create a bullet and add it to the scene
        let bullet = Bullet.build(at: playerDelegate.position)
        rootNode.addChildNode(bullet)
        
        // Shoot the bullet
        bullet.shoot(toward: playerDelegate.orientation)
        
        // Remove the bullet from the scene when its lifespan expires
        bullet.runAction(SCNAction.sequence([
            SCNAction.wait(duration: TimeInterval(Constants.Time.bulletLifespan.rawValue)),
            SCNAction.removeFromParentNode()
            ]))
    }
    
}

// MARK: - SCNPhysicsContactDelegate

extension Level: SCNPhysicsContactDelegate {
    
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        // Check which of the two nodes is an enemy and which a bullet
        let nodeA = contact.nodeA
        let nodeB = contact.nodeB
        
        if nodeA.physicsBody?.categoryBitMask == BitMaskCategory.enemy.rawValue {
            // Case 1: nodeA is an Enemy
            if nodeB.physicsBody?.categoryBitMask == BitMaskCategory.bullet.rawValue {
                handle(contact: contact, between: castToEnemy(theNode: nodeA), and: castToBullet(theNode: nodeB))
            } else if nodeB.physicsBody?.categoryBitMask == BitMaskCategory.player.rawValue {
                handle(contact: contact, between: castToEnemy(theNode: nodeA), and: castToPlayer(theNode: nodeB))
            }
        } else if nodeA.physicsBody?.categoryBitMask == BitMaskCategory.bullet.rawValue {
            // Case 2: nodeA is a Bullet...he can collide only with Enemy
            handle(contact: contact, between: castToEnemy(theNode: nodeB), and: castToBullet(theNode: nodeA))
        } else if nodeA.physicsBody?.categoryBitMask == BitMaskCategory.player.rawValue {
            // Case 2: nodeA is a Player...he can collide only with Enemy
            handle(contact: contact, between: castToEnemy(theNode: nodeB), and: castToPlayer(theNode: nodeA))
        }
    }
    
    private func handle(contact: SCNPhysicsContact, between enemy: Enemy, and bullet: Bullet) {
        print("Collision between Enemy and Bullet")
        
        let (explosion, killed) = enemy.hit(by: bullet, at: contact.contactPoint)
        
        // Add the explosion to the scene and remove the enemy if it is dead
        rootNode.addChildNode(explosion)
        if killed {
            playerScore.score += enemy.points
            
            remove(enemy: enemy)
        }
    }
    
    private func handle(contact: SCNPhysicsContact, between enemy: Enemy, and player: Player) {
        print("Collision between Enemy and Player")
        
        // Remove the player if it is dead
        let killed = player.hit(by: enemy, at: contact.contactPoint)
        if killed {
            playerScore.score = 0
            player.removeFromParentNode()
            // TODO: Game Over
        }
    }
    
    // MARK: Cast Utils
    
    private func castToEnemy(theNode: SCNNode) -> Enemy {
        guard let enemy = theNode as? Enemy else {
            fatalError("You have assigned the category bitmask of an Enemy to a non Enemy")
        }
        return enemy
    }
    
    private func castToBullet(theNode: SCNNode) -> Bullet {
        guard let bullet = theNode as? Bullet else {
            fatalError("You have assigned the category bitmask of a Bullet to a non Bullet")
        }
        return bullet
    }
    
    private func castToPlayer(theNode: SCNNode) -> Player {
        guard let player = theNode as? Player else {
            fatalError("You have assigned the category bitmask of an Player to a non Player")
        }
        return player
    }
    
}

// MARK: - Utils

extension Level {
    
    func add(enemy: Enemy) {
        rootNode.addChildNode(enemy)
        enemies.append(enemy)
    }
    
    func remove(enemy: Enemy) {
        if let index = enemies.index(of: enemy) {
            enemies.remove(at: index)
        }
        enemy.removeFromParentNode()
    }
    
}
