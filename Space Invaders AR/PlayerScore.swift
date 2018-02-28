//
//  PlayerScore.swift
//  Space Invaders AR
//
//  Created by Francesco Chiusolo on 28/02/2018.
//  Copyright © 2018 Francesco Chiusolo. All rights reserved.
//

import Foundation

// MARK: - Types

protocol PlayerScoreObserver {
    func update(_ score: Int)
}

class PlayerScore {
    
    // MARK: - Properties
    
    var observers: [PlayerScoreObserver]
    
    var score: Int {
        didSet {
            for observer in observers {
                observer.update(score)
            }
        }
    }
    
    // MARK: - Initializers
    
    init() {
        observers = []
        score = 0
    }
    
}
