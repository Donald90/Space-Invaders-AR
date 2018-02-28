//
//  Overlay.swift
//  Space Invaders AR
//
//  Created by Francesco Chiusolo on 28/02/2018.
//  Copyright © 2018 Francesco Chiusolo. All rights reserved.
//

import SpriteKit

class Overlay: SKScene {
    
    // MARK: - Properties
    
    static let scorePrefix = "⚽️"
    
    var scoreNode: SKLabelNode!
    
    // MARK: - Initializers
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Method init?(coder:) has not been implemented")
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        
        // TODO: Set up the HUD
        scoreNode = SKLabelNode(text: Overlay.scorePrefix)
        scoreNode.fontColor = UIColor.black
        scoreNode.fontSize = 24
        scoreNode.position = CGPoint(x: size.width / 2, y: 24 + 8)
        
        addChild(self.scoreNode)
    }
    
}

// MARK: - PlayerScoreObserver

extension Overlay: PlayerScoreObserver {
    
    func update(_ score: Int) {
        scoreNode.text = Overlay.scorePrefix + " \(score)"
    }
    
}
