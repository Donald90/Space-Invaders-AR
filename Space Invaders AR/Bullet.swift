//
//  Bullet.swift
//  Space Invaders AR
//
//  Created by Francesco Chiusolo on 27/02/2018.
//  Copyright © 2018 Francesco Chiusolo. All rights reserved.
//

import SceneKit

class Bullet: SCNNode {
    
    // MARK: - Initializers
    
    override init() {
        super.init()
        geometry = SCNSphere(radius: 0.01)
        geometry!.firstMaterial?.diffuse.contents = UIColor.green
        physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Method not implementhed")
    }
    
    // MARK: - Functions
    
    func shoot(toward: SCNVector3) {
        physicsBody?.applyForce(toward, asImpulse: true)
    }
    
}
