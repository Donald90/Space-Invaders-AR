//
//  Constants.swift
//  Space Invaders AR
//
//  Created by Francesco Chiusolo on 07/03/2018.
//  Copyright © 2018 Francesco Chiusolo. All rights reserved.
//

import Foundation

struct Constants {
    
    enum Time: TimeInterval {
        case enemySpawnInterval = 3
        case bulletLifeSpan = 2.5
    }
    
    enum Space: Float {
        case enemySpawnDistance = 2
    }
    
    // Expressed as m/s
    enum Velocity: Float {
        case enemy = 0.1
    }
    
}
