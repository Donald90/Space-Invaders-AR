//
//  Health.swift
//  Space Invaders AR
//
//  Created by Francesco Chiusolo on 16/03/2018.
//  Copyright © 2018 Francesco Chiusolo. All rights reserved.
//

import Foundation

protocol HealthObserver {
    var id: Int { get }
    func update(_ health: Int)
}

class Health {
    
    // MARK: - Properties
    
    private var observers: [HealthObserver] = []
    
    var health: Int {
        didSet {
            for observer in observers {
                observer.update(health)
            }
        }
    }
    
    // MARK: - Initializers
    
    init() {
        observers = []
        health = 3
    }
    
    // MARK: - Functions
    
    func attach(observer: HealthObserver) {
        observers.append(observer)
    }
    
    func detach(observer: HealthObserver) {
        if let index = observers.index(where: { $0.id == observer.id }) {
            observers.remove(at: index)
        }
    }
    
}
