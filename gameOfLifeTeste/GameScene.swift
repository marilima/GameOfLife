//
//  GameScene.swift
//  gameOfLifeTeste
//
//  Created by Mariana Lima on 31/10/19.
//  Copyright © 2019 Mariana Lima. All rights reserved.
//

import Foundation
import SceneKit

class GameScene: SCNScene {
    override init() {
        super.init()
        for xIndex: Int in 0...32 {
            for yIndex: Int in 0...32 {
                let geometry = SCNBox(width: 0.6, height: 0.6, length: 0.1, chamferRadius: 0.005)
                    geometry.firstMaterial?.diffuse.contents = UIColor.red
                    geometry.firstMaterial?.specular.contents = UIColor.systemPink
                    geometry.firstMaterial?.emission.contents = UIColor.blue
                    let boxNode = SCNNode(geometry: geometry)
                    let offSet: Int = 16
                let boxCopy = boxNode.copy() as! SCNNode
                    boxCopy.position.x = Float(xIndex - offSet)
                    boxCopy.position.y = Float(yIndex - offSet)
                self.rootNode.addChildNode(boxCopy)
            }
        }
    }
    required init?(coder aDeCoder: NSCoder) {
        super.init(coder: aDeCoder)
    }
}
