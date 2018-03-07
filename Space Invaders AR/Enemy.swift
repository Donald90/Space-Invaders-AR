//
//  Enemy.swift
//  Space Invaders AR
//
//  Created by Francesco Chiusolo on 27/02/2018.
//  Copyright © 2018 Francesco Chiusolo. All rights reserved.
//

import SceneKit

class Enemy: SCNNode {
    
    // MARK: - Properties
    
    // How much the player get if he kill this enemy
    let points: Int = Constants.Points.enemy.rawValue
    
    var life: Int = Constants.Life.enemy.rawValue
    
    let damage: Int = Constants.Damage.enemy.rawValue
    
    // MARK: - Initializers
    
    override init() {
        super.init()
        geometry = SCNSphere(radius: 0.1)
        geometry!.firstMaterial?.diffuse.contents = UIColor.red
        physicsBody = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(node: self))
        physicsBody?.isAffectedByGravity = false
        physicsBody?.categoryBitMask = BitMaskCategory.enemy.rawValue
        physicsBody?.contactTestBitMask = BitMaskCategory.bullet.rawValue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Method not implementhed")
    }
    
    // MARK: - Gameplay
    
    func hit(by bullet: Bullet, at contactPoint: SCNVector3) -> (SCNNode, Bool) {
        // Decrease enemy life by damage of the bullet it was hit by
        life -= bullet.damage
        
        // Build the explosion
        let explosionNode = SCNParticleSystem.build(explode: self, at: contactPoint)
        
        return (explosionNode, life <= 0)
    }
    
    func follow(player target: SCNVector3, deltaTime: TimeInterval) {
        debugPrint(deltaTime)
        let toPlayer = target - position
        position = position + (toPlayer * Float(deltaTime))
    }
    
}
