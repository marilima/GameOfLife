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
    
    let offset: Int = 10
    let tamanho: Int = 50
    
    override init() {
        
        super.init()
        for x in 0...tamanho-1 {
            var row = [Cell]()
            for y in 0...tamanho-1 {
                let cell = Cell()
                cell.position.x = Float(x - offset)
                cell.position.y = Float(y - offset)
                row.append(cell)
                self.rootNode.addChildNode(cell)
                
            }
        }
    }
    required init?(coder aDeCoder: NSCoder) {
        super.init(coder: aDeCoder)
    }
}
