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
    
    static let spawnInterval: TimeInterval = 3
    
    var delegate: LevelDelegate?
    
    let playerScore: PlayerScore
    
    // MARK: - Initializers
    
    init(playerScore: PlayerScore) {
        self.playerScore = playerScore
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Method init?(coder:) not implemented")
    }
    
    // MARK: - Gameplay
    
    func run() {
        Timer.scheduledTimer(withTimeInterval: Level.spawnInterval, repeats: true) { (_) in
            _ = Enemy.spawn(for: self, whenPlayerIsAt: self.delegate?.playerPosition ?? SCNVector3Zero)
        }
    }
    
    func tap() {
        guard let delegate = delegate else {
            fatalError("Level need to know where the user is to shoot a bullet")
        }
        
        let bullet = Bullet.build(for: self, at: delegate.playerPosition)
        print("Player position: \(delegate.playerPosition)")
        // TODO: Shoot the bullet toward where the user is looking at
        bullet.shoot(toward: delegate.playerOrientation)
    }
    
}
