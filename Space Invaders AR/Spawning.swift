//
//  Spawning.swift
//  Space Invaders AR
//
//  Created by Francesco Chiusolo on 27/02/2018.
//  Copyright © 2018 Francesco Chiusolo. All rights reserved.
//

import SceneKit

extension Enemy {
    
    // FIXME: Set the spawnDistance to 2 meters
    static let spawnDistance: Float = 2
    
    static func spawn(in scene: SCNScene, whenPlayerIsAt position: SCNVector3) -> Enemy {
        // TODO: Build different types of enemies with a factory
        let enemy = Enemy()
        
        let transform = SCNMatrix4Identity
            // Move to player position
            .translate(tx: position.x, ty: position.y, tz: position.z)
            // Move forward of spawnDistance amount
            .translate(tx: 0, ty: 0, tz: spawnDistance)
            // Rotate over y axis of a random angle so it stays on the horizon
            .rotate(angle: Float.random(min: -.pi, max: .pi), axis: .y)
        enemy.transform = transform
        
        scene.rootNode.addChildNode(enemy)
        return enemy
    }
    
}

extension Bullet {
    
    static func build(in scene: SCNScene, at position: SCNVector3) -> Bullet {
        // TODO: Build different types of bullets with a factory
        let bullet = Bullet()
        bullet.position = position
        scene.rootNode.addChildNode(bullet)
        return bullet
    }
    
}

extension SCNParticleSystem {
    
    static func build(in scene: SCNScene, explode enemyNode: SCNNode, at contactPoint: SCNVector3) {
        let explosion = SCNParticleSystem(named: "EnemyExplosion.scnp", inDirectory: "art.scnassets")
        explosion?.loops = false
        explosion?.particleLifeSpan = 4
        explosion?.emitterShape = enemyNode.geometry
        
        let explosionNode = SCNNode()
        explosionNode.addParticleSystem(explosion!)
        explosionNode.position = contactPoint
        scene.rootNode.addChildNode(explosionNode)
    }
    
}
