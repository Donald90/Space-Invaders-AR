//
//  SIVector2.swift
//  Space Invaders AR
//
//  Created by Francesco Chiusolo on 15/03/2018.
//  Copyright © 2018 Francesco Chiusolo. All rights reserved.
//

import Foundation
import SceneKit

class SIVector2 {
    
    // MARK: - Properties
    
    let x: Float
    let y: Float
    
    // MARK: - Initializers
    
    init(x: Float, y: Float) {
        self.x = x
        self.y = y
    }
    
    convenience init(from vector: SCNVector3) {
        // The vector as seen from the above
        self.init(x: vector.x, y: vector.z)
    }
    
    // MARK: - Operations
    
    static func cross(_ a: SIVector2, _ b: SIVector2) -> Float {
        return (a.x * b.y) - (a.y * b.x)
    }
    
    static func cross(_ a: SCNVector3, _ b: SCNVector3) -> Float {
        let a2D = SIVector2(from: a)
        let b2D = SIVector2(from: b)
        return SIVector2.cross(a2D, b2D)
    }
    
    func module() -> Float {
        return sqrtf((x * x) + (y * y))
    }
    
}
