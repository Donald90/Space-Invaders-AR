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
    
    static let power: Float = 50
    
    static let lifespan: TimeInterval = 2.5
    
    // MARK: - Initializers
    
    override init() {
        super.init()
        geometry = SCNSphere(radius: 0.1)
        geometry!.firstMaterial?.diffuse.contents = UIColor.green
        physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Method not implementhed")
    }
    
    // MARK: - Functions
    
    func shoot(toward: SCNVector3) {
        // Apply an impulse to the bullet
        physicsBody?.applyForce(toward * Bullet.power, asImpulse: true)
        
        // Remove the bullet from the scene when its lifespan expires
        Timer.scheduledTimer(withTimeInterval: Bullet.lifespan, repeats: false) { (_) in
            self.removeFromParentNode()
        }
    }
    
}
