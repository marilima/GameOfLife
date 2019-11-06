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
        scene2?.printGrid()
        scene2?.updateGrid()
        placesBox()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = SCNScene()
        
        scnView.scene = scene
        scene2 = GameScene(tamanho: 32)
        scnView.pointOfView?.position = SCNVector3Make(0, 0, 0)
        setupLight(rootNode: scene.rootNode)
        setupCamera(rootNode: scene.rootNode)
        createGrid(rootNode: scene.rootNode)
        for i in gridBoxes {
            for j in i {
                scene.rootNode.addChildNode(j ?? SCNNode())
            }
        }
        Box.shared.setColors(deadColor: .systemBlue, aliveColor: .systemRed)
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
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 20)
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
    
    func createBox(x: Int, y: Int, tamanho: Int) -> SCNNode {
        let boxNode = SCNNode(geometry: Box.shared.geometryDead)
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
            for j in 0..<grid.tamanho {
                self.gridBoxes[i].append(createBox(x: i, y: j, tamanho: grid.tamanho))
            }
        }
    }
    
    func placesBox() {
        guard let grid = self.scene2?.grid else { return }
        for i in 0..<grid.count {
            for j in 0..<grid.count {
                let cell = grid[i][j]
                let boxNode = gridBoxes[i][j]
                if cell.estado == .alive {
                    boxNode?.geometry = Box.shared.geometryAlive
                }
                else {
                    boxNode?.geometry = Box.shared.geometryDead
                }
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
            let index = findCell(node: result.node)
            let cell = scene2?.grid[index.i][index.j]
            
//            // get its material
//            let material = result.node.geometry!.firstMaterial!
//            
            // highlight it
            SCNTransaction.begin()
            SCNTransaction.animationDuration = 0.5
            
            // on completion - unhighlight
            SCNTransaction.completionBlock = {
                SCNTransaction.begin()
                SCNTransaction.animationDuration = 0.5
                SCNTransaction.commit()
            }
            
            switch cell?.estado {
            case .alive:
                result.node.geometry = Box.shared.geometryDead
                cell?.estado = .dead
                break
            case .dead:
                result.node.geometry = Box.shared.geometryAlive
                cell?.estado = .alive
                break
            default :
                break
            }
            SCNTransaction.commit()
            
        }
    }
    func findCell(node: SCNNode) -> (i: Int, j: Int) {
        for i in 0..<gridBoxes.count {
            if let j = gridBoxes[i].firstIndex(of: node) {
                return (i, j)
            }
        }
        return (0, 0)
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
