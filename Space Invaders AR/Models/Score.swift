//
//  Score.swift
//  Space Invaders AR
//
//  Created by Francesco Chiusolo on 28/02/2018.
//  Copyright © 2018 Francesco Chiusolo. All rights reserved.
//

import Foundation

// MARK: - Types

protocol ScoreObserver {
    var id: Int { get }
    func update(_ score: Int)
}

class Score {
    
    // MARK: - Properties
    
    private var observers: [ScoreObserver] = []
    
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
    
    // MARK: - Functions
    
    func attach(observer: ScoreObserver) {
        observers.append(observer)
    }
    
    func detach(observer: ScoreObserver) {
        if let index = observers.index(where: { $0.id == observer.id }) {
            observers.remove(at: index)
        }
    }
    
}
