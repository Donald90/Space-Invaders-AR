//
//  matrix_float4x4.swift
//  Space Invaders AR
//
//  Created by Francesco Chiusolo on 27/02/2018.
//  Copyright © 2018 Francesco Chiusolo. All rights reserved.
//

import SceneKit

extension matrix_float4x4 {
    
    var position: SCNVector3 {
        get {
            let translation = columns.3
            return SCNVector3(translation.x, translation.y, translation.z)
        }
        set(newValue) {
            columns.3 = float4(newValue.x, newValue.y, newValue.z, columns.3.w)
        }
    }
    
}

extension SCNMatrix4 {
    
    var orientation: SCNVector3 {
        return SCNVector3(-m31, -m32, -m33)
    }
    
}
