//
//  Player.swift
//  Space Invaders AR
//
//  Created by Francesco Chiusolo on 07/03/2018.
//  Copyright © 2018 Francesco Chiusolo. All rights reserved.
//

import SceneKit

class Player: SCNNode {
    
    // MARK: - Properties
    
    var life: Int = Constants.Life.player.rawValue
    
    // MARK: - Initializers
    
    override init() {
        super.init()
        geometry = SCNSphere(radius: 0.05)
        geometry!.firstMaterial?.diffuse.contents = UIColor.blue
//        geometry!.firstMaterial?.isDoubleSided = true
        physicsBody = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(node: self))
        physicsBody?.isAffectedByGravity = false
        physicsBody?.categoryBitMask = BitMaskCategory.player.rawValue
        physicsBody?.contactTestBitMask = BitMaskCategory.enemy.rawValue
        physicsBody?.collisionBitMask = BitMaskCategory.enemy.rawValue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Method init?(coder:) not implemented")
    }
    
    // MARK: - Gameplay
    
    func hit(by enemy: Enemy, at contactPoint: SCNVector3) -> Bool {
        life -= enemy.damage
        return life <= 0
    }
    
}
