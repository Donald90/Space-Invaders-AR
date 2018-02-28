//
//  Level.swift
//  Space Invaders AR
//
//  Created by Francesco Chiusolo on 27/02/2018.
//  Copyright © 2018 Francesco Chiusolo. All rights reserved.
//

import SceneKit

protocol LevelDelegate {
    var playerPosition: SCNVector3 { get }
    var playerOrientation: SCNVector3 { get }
}

class Level: SCNScene {
    
    // MARK: - Properties
    
    var delegate: LevelDelegate?
    
    var enemies = [Enemy]()
    
    // MARK: - Initializers
    
    override init() {
        super.init()
        let enemy = Enemy.spawn(for: self)
        enemies.append(enemy)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Method init?(coder:) not implemented")
    }
    
    // MARK: - Gameplay
    
    func tap() {
        guard let delegate = delegate else {
            fatalError("Level need to know where the user is to shoot a bullet")
        }
        
        let bullet = Bullet.build(for: self, at: delegate.playerPosition)
        // TODO: Shoot the bullet toward where the user is looking at
        bullet.shoot(toward: delegate.playerOrientation)
    }
    
}
