//
//  ViewController.swift
//  Space Invaders AR
//
//  Created by Francesco Chiusolo on 27/02/2018.
//  Copyright © 2018 Francesco Chiusolo. All rights reserved.
//

import UIKit
import SpriteKit
import SceneKit
import ARKit

class ViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet var sceneView: ARSCNView!
    
    // MARK: - Properties
    
    var score: PlayerScore?
    
    var level: Level?
    
    var overlay: Overlay?
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    // MARK: - Actions
    
    @IBAction func handleTap(_ sender: UITapGestureRecognizer) {
        if let level = level {
            level.tap()
        }
    }
    
}

// MARK: - LevelDelegate

extension ViewController: PlayerDelegate {
    
    var position: SCNVector3 {
        //        guard let transform = sceneView.pointOfView?.transform else {
        //            return SCNVector3Zero
        //        }
        //        let orientation = SCNVector3(-transform.m31, -transform.m32, -transform.m33)
        //        let location = SCNVector3(transform.m41, transform.m42, transform.m43)
        //        return orientation + location
        guard let transform = sceneView.session.currentFrame?.camera.transform else { return SCNVector3Zero }
        return transform.position
    }
    
    var orientation: SCNVector3 {
        guard let transform = sceneView.pointOfView?.transform else {
            return SCNVector3Zero
        }
        let orientation = SCNVector3(-transform.m31, -transform.m32, -transform.m33)
        return orientation
    }
    
}

// MARK: - ARSessionDelegate

extension ViewController: ARSessionDelegate {
    
    func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
        switch camera.trackingState {
        case .normal:
            print("Ready")
            if level == nil {
                score = PlayerScore()
                
                // Set the current level
                level = Level(playerScore: score!)
                level!.playerDelegate = self
                sceneView.scene = level!
                
                // Set the overlay HUD
                overlay = Overlay(size: view.bounds.size)
                sceneView.overlaySKScene = overlay
                
                score!.observers.append(overlay!)
            }
        default:
            print("Not ready")
        }
    }
    
}

// MARK: - ARSCNViewDelegate

extension ViewController: ARSCNViewDelegate {
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        level?.update(updateAtTime: time)
    }
    
}
