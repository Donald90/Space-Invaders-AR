//
//  Spawning.swift
//  Space Invaders AR
//
//  Created by Francesco Chiusolo on 27/02/2018.
//  Copyright © 2018 Francesco Chiusolo. All rights reserved.
//

import SceneKit

extension Enemy {
    
    static func spawn(for scene: SCNScene) -> Enemy {
        // TODO: Build different types of enemies with a factory
        let enemy = Enemy()
        enemy.position = SCNVector3Zero
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
