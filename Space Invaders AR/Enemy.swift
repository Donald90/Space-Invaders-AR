//
//  Enemy.swift
//  Space Invaders AR
//
//  Created by Francesco Chiusolo on 27/02/2018.
//  Copyright © 2018 Francesco Chiusolo. All rights reserved.
//

import SceneKit

class Enemy: SCNNode {

    // MARK: - Initializers
    
    override init() {
        super.init()
        geometry = SCNSphere(radius: 0.1)
        geometry!.firstMaterial?.diffuse.contents = UIColor.red
        physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        physicsBody?.isAffectedByGravity = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Method not implementhed")
    }
    
}
