//
//  Radar.swift
//  Space Invaders AR
//
//  Created by Francesco Chiusolo on 15/03/2018.
//  Copyright © 2018 Francesco Chiusolo. All rights reserved.
//

import Foundation
import SceneKit

class Radar {
    
    // MARK: - Initializers
    
    init() {}
    
    // MARK: - Updating
    
    func update(deltaTime: TimeInterval, player: SCNVector3, target: SCNVector3) -> DirectionValue {
        // Calculate the cross product of the two vectors projected on the (x, z) axis
        // like if we see them from the top.
        let crossProduct = SIVector2.cross(heading: player, target: target)
        
        // Based on the cross product result, return the direction
        if crossProduct == 0 {
            return .front
        } else if crossProduct == -0 {
            return .behind
        } else if crossProduct < 0 {
            return .left
        } else if crossProduct > 0 {
            return .right
        }
        
        // IDK if we can get here, anyway let's make Xcode happy 😃
        return .unknown
    }
    
}
