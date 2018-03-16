//
//  Direction.swift
//  Space Invaders AR
//
//  Created by Francesco Chiusolo on 16/03/2018.
//  Copyright © 2018 Francesco Chiusolo. All rights reserved.
//

import Foundation

// MARK: - Types

enum DirectionValue {
    case front, right, behind, left, unknown
}

// MARK: - Protocols

protocol DirectionObserver {
    var id: Int { get }
    func update(_ value: DirectionValue)
}

// MARK: - Class

class Direction {
    
    // MARK: - Properties
    
    private var observers: [DirectionObserver] = []
    
    var value: DirectionValue {
        didSet {
            for observer in observers {
                observer.update(value)
            }
        }
    }
    
    // MARK: - Initializers
    
    init() {
        observers = []
        value = .unknown
    }
    
    // MARK: - Functions
    
    func attach(observer: DirectionObserver) {
        observers.append(observer)
    }
    
    func detach(observer: DirectionObserver) {
        if let index = observers.index(where: { $0.id == observer.id }) {
            observers.remove(at: index)
        }
    }
    
}

