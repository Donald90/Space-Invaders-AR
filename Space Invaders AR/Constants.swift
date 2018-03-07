//
//  Constants.swift
//  Space Invaders AR
//
//  Created by Francesco Chiusolo on 07/03/2018.
//  Copyright © 2018 Francesco Chiusolo. All rights reserved.
//

import Foundation

struct Constants {
    
    // Expressed as s
    enum Time: TimeInterval {
        case enemySpawnInterval = 3
        case bulletLifespan = 2.5
        case explosionLifespan = 2
    }
    
    // Expressed as m
    enum Space: Float {
        case enemySpawnDistance = 2
    }
    
    // Expressed as m/s
    enum Velocity: Float {
        case enemy = 0.1
    }
    
    enum Life: Int {
        case enemy = 2
        case player = 3
    }
    
    enum Damage: Int {
        case enemy = 1
        case bullet = 2
    }
    
    enum Force: Float {
        case bulletImpulse = 25
    }
    
    enum Points: Int {
        case enemy = 1
    }
    
}
