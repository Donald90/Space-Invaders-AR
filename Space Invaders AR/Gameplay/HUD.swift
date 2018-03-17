//
//  Overlay.swift
//  Space Invaders AR
//
//  Created by Francesco Chiusolo on 28/02/2018.
//  Copyright © 2018 Francesco Chiusolo. All rights reserved.
//

import SpriteKit

class HUD: SKScene {
    
    // MARK: - Properties
    
    var scoreNode: SKLabelNode!
    
    var directionNode: SKLabelNode!
    
    // MARK: - Initializers
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Method init?(coder:) has not been implemented")
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        
        // TODO: Set up the HUD
        scoreNode = SKLabelNode(text: "")
        scoreNode.fontColor = UIColor.black
        scoreNode.fontSize = 24
        scoreNode.position = CGPoint(x: size.width / 2, y: 24 + 8)
        
        directionNode = SKLabelNode(text: "")
        directionNode.fontColor = UIColor.black
        directionNode.fontSize = 24
        directionNode.position = CGPoint(x: size.width / 2, y: size.height - 24 - 8)
        
        addChild(scoreNode)
        addChild(directionNode)
    }
    
    convenience init(size: CGSize, score: Score, direction: Direction) {
        self.init(size: size)
        score.attach(observer: self)
        direction.attach(observer: self)
    }
    
}

// MARK: - ScoreObserver

extension HUD: ScoreObserver {
    
    var id: Int {
        return Constants.ID.overlay.rawValue
    }
    
    func update(_ score: Int) {
        scoreNode.text = String(score)
    }
    
}

// MARK: - DirectionObserver

extension HUD: DirectionObserver {
    
    func update(_ value: DirectionValue) {
        directionNode.text = value.rawValue
    }
    
}
