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
    
    var initialCellStatus : State
    var finalCellStatus : State
    var minCellNeighbours : Int
    var maxCellNeighbours : Int
    
    init(initialCellStatus: State, finalCellStatus: State, minCellNeighbours: Int, maxCellNeighbours: Int) {
        self.initialCellStatus = initialCellStatus
        self.finalCellStatus = finalCellStatus
        self.minCellNeighbours = minCellNeighbours
        self.maxCellNeighbours = maxCellNeighbours
        
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//    func checkNeighbours(cell: Cell) {
// 
//        }
}
