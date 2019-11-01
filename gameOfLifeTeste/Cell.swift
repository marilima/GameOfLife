//
//  Cell.swift
//  gameOfLifeTeste
//
//  Created by Mariana Lima on 31/10/19.
//  Copyright © 2019 Mariana Lima. All rights reserved.
//

import Foundation
import SceneKit

enum State {
    case alive
    case dead
}
class Cell: SCNNode {
    var estado: State?

    override init() {
        super.init()
        self.estado = .dead
        
        let geometry = SCNBox(width: 0.6, height: 0.6, length: 0.1, chamferRadius: 0.005)
        self.geometry = geometry
    }
    required init?(coder aDeCoder: NSCoder) {
        super.init(coder: aDeCoder)
    }
}

