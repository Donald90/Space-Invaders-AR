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
    
    let score: Int = 1
    
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
    
    // MARK: - Functions
    
    func hit(by bullet: Bullet, in scene: SCNScene, at contactPoint: SCNVector3) -> Bool {
        // TODO: Check bullet damage and compare to enemy life
        SCNParticleSystem.build(in: scene, explode: self, at: contactPoint)
        removeFromParentNode()
        return true
    }
    
    func update(deltaTime time: TimeInterval) {
        print("Updating enemy")
    }
    
}
