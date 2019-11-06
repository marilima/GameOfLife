//
//  Cell.swift
//  gameOfLifeTeste
//
//  Created by Mariana Lima on 31/10/19.
//  Copyright © 2019 Mariana Lima. All rights reserved.
//

import Foundation
import SceneKit

class Cell {
    var estado: State?
    var aliveNeighbours: Int
    var position: (x: Int, y: Int)
    
    init(x: Int, y: Int) {
        estado = .dead
        position = (x,y)
        aliveNeighbours = 0
        //        let geometry = SCNBox(width: 0.5, height: 0.5, length: 0.08, chamferRadius: 0.005)
        //        self.geometry = geometry
    }
    func copyCell() -> Cell {
        let newCell = Cell(x: position.x, y: position.y)
        newCell.aliveNeighbours = aliveNeighbours
        newCell.estado = estado
        return newCell
    }
}

enum State {
    case alive
    case dead
}


