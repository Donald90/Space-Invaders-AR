//
//  Bullet.swift
//  Space Invaders AR
//
//  Created by Francesco Chiusolo on 27/02/2018.
//  Copyright © 2018 Francesco Chiusolo. All rights reserved.
//

import SceneKit

class Bullet: SCNNode {
    
    // MARK: - Properties
    
    let power = Constants.Force.bulletImpulse.rawValue
    
    let damage: Int = Constants.Damage.bullet.rawValue
    
    // MARK: - Initializers
    
    override init() {
        super.init()
        geometry = SCNSphere(radius: 0.025)
        geometry!.firstMaterial?.diffuse.contents = UIColor.green
        physicsBody = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(node: self))
        physicsBody?.categoryBitMask = BitMaskCategory.bullet.rawValue
        physicsBody?.contactTestBitMask = BitMaskCategory.enemy.rawValue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Method not implementhed")
    }
    
    // MARK: - Functions
    
    func shoot(toward: SCNVector3) {
        // Apply an impulse to the bullet
        physicsBody?.applyForce(toward * power, asImpulse: true)
        
        // Remove the bullet from the scene when its lifespan expires
        runAction(SCNAction.sequence([
            SCNAction.wait(duration: TimeInterval(Constants.Time.bulletLifeSpan.rawValue)),
            SCNAction.removeFromParentNode()
            ]))
    }
    
}
