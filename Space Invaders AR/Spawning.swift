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
    
    static func spawn(for scene: SCNScene, whenPlayerIsAt position: SCNVector3) -> Enemy {
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
    
    static func build(for scene: SCNScene, at position: SCNVector3) -> Bullet {
        // TODO: Build different types of bullets with a factory
        let bullet = Bullet()
        bullet.position = position
        scene.rootNode.addChildNode(bullet)
        return bullet
    }
    
}
