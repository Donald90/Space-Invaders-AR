//
//  Random.swift
//  Space Invaders AR
//
//  Created by Francesco Chiusolo on 28/02/2018.
//  Copyright © 2018 Francesco Chiusolo. All rights reserved.
//

import Foundation

extension Float {
    public static func random(min: Float, max: Float) -> Float {
        let r32 = Float(arc4random()) / Float(UInt32.max)
        return (r32 * (max - min)) + min
    }
}
