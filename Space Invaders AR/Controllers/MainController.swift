//
//  MainController.swift
//  Space Invaders AR
//
//  Created by Francesco Chiusolo on 27/02/2018.
//  Copyright © 2018 Francesco Chiusolo. All rights reserved.
//

import UIKit
import SpriteKit
import SceneKit
import ARKit

class MainController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet var sceneView: ARSCNView!
    
    // MARK: - Properties
    
    var lastRenderTime: TimeInterval?
    
    var game: Game?
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        sceneView.session.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        
        // Init the game object
        game = Game(view: view, playerDelegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // Run the view's session
        sceneView.session.run(configuration)
        
        // TODO: Start loading game assets here.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    // MARK: - Actions
    
    @IBAction func handleTap(_ sender: UITapGestureRecognizer) {
        if let game = game {
            game.tap()
        }
    }
    
}

// MARK: - PlayerDelegate

extension MainController: PlayerDelegate {
    
    var position: SCNVector3 {
        guard let transform = sceneView.session.currentFrame?.camera.transform else { return SCNVector3Zero }
        return transform.position
    }
    
    var orientation: SCNVector3 {
        guard let transform = sceneView.pointOfView?.transform else {
            return SCNVector3Zero
        }
        return transform.orientation
    }
    
}

// MARK: - ARSessionDelegate

extension MainController: ARSessionDelegate {
    
    func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
        switch camera.trackingState {
            
        case .notAvailable:
            print("WTF 😨")
            
        case .limited(let reason):
            switch reason {
                
            case .initializing:
                print("I've heard something...look around")
                
            case .excessiveMotion:
                print("Baby slow down the so o o o o ou o o o o ou o o o o ieeeee baby slow down the song")
                
            case .insufficientFeatures:
                print("🕯🕯🕯")
            }
            
        case .normal:
            print("AR ready")
            guard let game = game, game.state == .ready else {
                return
            }
            
            sceneView.scene = game.scene
            sceneView.overlaySKScene = game.hud
            
            game.start()
        }
    }
    
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        guard let game = game else { return }
        
        let cameraPosition = frame.camera.transform.position
        game.update(player: cameraPosition)
    }
    
}

// MARK: - ARSCNViewDelegate

extension MainController: ARSCNViewDelegate {
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        guard let game = game else { return }
        
        // If lastUpdateTime is undefined, assign it
        // the update time. This happens only the at the first update so we can skip it.
        guard let lastRenderTime = self.lastRenderTime else {
            self.lastRenderTime = time
            return
        }
        
        // Update the game by the amount of time since last update
        let deltaTime = time - lastRenderTime
        game.update(deltaTime: deltaTime)
        
        // Update lastUpdateTime to match this current time
        self.lastRenderTime = time
    }
    
}
