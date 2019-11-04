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
    var rules = [Rule]()
    var grid = [Cell]()
    var newGrid = [Cell]()
    let offset: Int = 10
    let tamanho: Int = 50
    
    override init() {
        super.init()
        for x in 0...tamanho - 1 {
            var row = [Cell]()
            for y in 0...tamanho - 1 {
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
      func acountNeighbours() {
        
        let cell = Cell()
        var counterVizinho = 0
        var i = cell.position.x - 1
        
        while i < cell.position.x + 1 {
            var j: Float = 0
                while j < cell.position.y - 1 {
                    if (cell.position.x != i || cell.position.y != j) && i > 0 && j > 0  && Int(j) < tamanho && Int(i) < tamanho {
                        counterVizinho = counterVizinho + 1
                    }
                    j = j + 1
                }
            i = i + 1
            }
        }
    
      func updateGrid(){
        var newGrid = [[Cell]]()
        
        for i in 0...tamanho - 1{
           var row = [Cell]()
            for y in 0...tamanho - 1 {
                let cell = Cell()
                
            }
                
        }
        
    }
      func addNewRules(){
       rules.append(Rule(initialCellStatus: .alive, finalCellStatus: .dead, minCellNeighbours: 0, maxCellNeighbours: 1))
        rules.append(Rule(initialCellStatus: .alive, finalCellStatus: .dead, minCellNeighbours: 4, maxCellNeighbours: 8))
       rules.append(Rule(initialCellStatus: .alive, finalCellStatus: .alive, minCellNeighbours: 2, maxCellNeighbours: 3))
        rules.append(Rule(initialCellStatus: .dead, finalCellStatus: .alive, minCellNeighbours: 3, maxCellNeighbours: 3))
      }
    
}
