//
//  SCNMatrix4.swift
//  Space Invaders AR
//
//  Created by Francesco Chiusolo on 28/02/2018.
//  Copyright © 2018 Francesco Chiusolo. All rights reserved.
//

import SceneKit

extension SCNMatrix4 {
    
    enum Axis {
        case x, y, z
    }
    
    func rotate(angle: Float, x: Float, y: Float, z: Float) -> SCNMatrix4 {
        return SCNMatrix4Rotate(self, angle, x, y, z)
    }
    
    func rotate(angle: Float, axis: Axis) -> SCNMatrix4 {
        let x = axis == .x ? Float(1.0) : Float(0.0)
        let y = axis == .y ? Float(1.0) : Float(0.0)
        let z = axis == .z ? Float(1.0) : Float(0.0)
        return SCNMatrix4Rotate(self, angle, x, y, z)
    }
    
    func translate(tx: Float, ty: Float, tz: Float) -> SCNMatrix4 {
        return SCNMatrix4Translate(self, tx, ty, tz)
    }
    
}
