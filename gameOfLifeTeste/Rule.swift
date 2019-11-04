//
//  Rule.swift
//  gameOfLifeTeste
//
//  Created by Mariana Lima on 04/11/19.
//  Copyright © 2019 Mariana Lima. All rights reserved.
//

import Foundation
import SceneKit


class Rule: SCNScene {
    
    init(initialCellStatus: State, finalCellStatus: State, minCellNeighbours: Int, maxCellNeighbours: Int) {
        
        var initialCellStatus = initialCellStatus
        var finalCellStatus = finalCellStatus
        var minCellNeighbours = minCellNeighbours
        var maxCellNeighbours = maxCellNeighbours
        super.init()
    }
    required init?(coder aDeCoder: NSCoder) {
        super.init(coder: aDeCoder)
    }
    
    func checkNeighbours() {
        
    }
    
    
}
