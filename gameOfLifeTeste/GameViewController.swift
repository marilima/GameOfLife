//
//  GameViewController.swift
//  gameOfLifeTeste
//
//  Created by Mariana Lima on 31/10/19.
//  Copyright © 2019 Mariana Lima. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class GameViewController: UIViewController {
    
    var scene2: GameScene?
    
    var cameraNode: SCNNode!
    var gridBoxes: [[SCNNode?]] = []
    
    @IBOutlet weak var scnView: SCNView!
    @IBAction func playButton(_ sender: Any) {
        scene2?.updateGrid()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         let scene = SCNScene()
        
            scnView.scene = scene
          scene2 = GameScene(tamanho: 32)
        scnView.pointOfView?.position = SCNVector3Make(0, 0, 0)
        setupLight(rootNode: scene.rootNode)
        setupCamera(rootNode: scene.rootNode)
        setupSphere(rootNode: scene.rootNode)
        createGrid(rootNode: scene.rootNode)
        
        // allows the user to manipulate the camera
        scnView.allowsCameraControl = true
        
        // show statistics such as fps and timing information
        scnView.showsStatistics = false
        
        // configure the view
        scnView.backgroundColor = UIColor.systemFill
        
        // add a tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        scnView.addGestureRecognizer(tapGesture)
    }
    //      funcao de arrumar a camera
            func setupCamera(rootNode: SCNNode) {
                cameraNode = SCNNode()
                cameraNode.camera = SCNCamera()
                cameraNode.position = SCNVector3(x: 0, y: 0, z: 60)
                rootNode.addChildNode(cameraNode)
            }
    //      funcao de colocar a luz e ambiente
            func setupLight(rootNode: SCNNode) {
                let lightNode = SCNNode()
                lightNode.light = SCNLight()
                lightNode.light!.type = .omni
                lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
                rootNode.addChildNode(lightNode)
                
                let ambientLightNode = SCNNode()
                ambientLightNode.light = SCNLight()
                ambientLightNode.light!.type = .ambient
                ambientLightNode.light!.color = UIColor.darkGray
                rootNode.addChildNode(ambientLightNode)
            }
    //      funcao que adiciona a esfera e a animacao
            func setupSphere(rootNode: SCNNode) {
                let geometry = SCNSphere(radius: 0.5)
                let botao = SCNNode()
                botao.geometry = geometry
                botao.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 2, z: 0, duration: 1)))
                rootNode.addChildNode(botao)
            }
    func createBox(x: Int, y: Int, tamanho: Int) -> SCNNode {
        let boxNode = SCNNode(geometry: Box.shared.geometryAlive)
        boxNode.position.x = Float(x - tamanho/2)
        boxNode.position.y = Float(y - tamanho/2)
        boxNode.position.z = 0.5
        
        return boxNode
    }
    func createGrid(rootNode: SCNNode) {
        guard let grid = self.scene2 else {
            return }
        for i in 0..<grid.tamanho {
            self.gridBoxes.append([SCNNode]())
            for _ in 0..<grid.tamanho {
                self.gridBoxes[i].append(nil)
            }
        }
    }
    @objc
    func handleTap(_ gestureRecognize: UIGestureRecognizer) {
        // retrieve the SCNView
        
        // check what nodes are tapped
        let p = gestureRecognize.location(in: scnView)
        let hitResults = scnView.hitTest(p, options: [:])
        // check that we clicked on at least one object
        if hitResults.count > 0 {
            // retrieved the first clicked object
            let result = hitResults[0]
            
            // get its material
            let material = result.node.geometry!.firstMaterial!
            
            // highlight it
            SCNTransaction.begin()
            SCNTransaction.animationDuration = 0.5
            
            // on completion - unhighlight
            SCNTransaction.completionBlock = {
                SCNTransaction.begin()
                SCNTransaction.animationDuration = 0.5
                SCNTransaction.commit()
            }
            if let node = result.node as? Cell {
                switch node.estado {
                case .alive:
                    material.diffuse.contents = UIColor.systemPurple
                    node.estado = .dead
                default:
                    material.diffuse.contents = UIColor.systemBlue
                    node.estado = .alive
                }
                SCNTransaction.commit()
            }
        }
    }
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
}
