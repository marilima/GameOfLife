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

class Box {
    static let shared = Box()
    
    private init() {}
    
    var geometryAlive = SCNBox(width: 0.9, height: 0.9, length: 0.9, chamferRadius: 0.005)
    var geometryDead = SCNBox(width: 0.9, height: 0.9, length: 0.9, chamferRadius: 0.005)
    
    func setColors(deadColor: UIColor, aliveColor: UIColor) {
        geometryAlive.firstMaterial?.diffuse.contents = aliveColor
        geometryDead.firstMaterial?.diffuse.contents = deadColor
    }
    
}

