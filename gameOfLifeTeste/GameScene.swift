//
//  GameScene.swift
//  gameOfLifeTeste
//
//  Created by Mariana Lima on 31/10/19.
//  Copyright © 2019 Mariana Lima. All rights reserved.
//

import Foundation
import SceneKit
import UIKit
import QuartzCore

class GameScene {
    var grid : [[Cell]]
    var offset: Int = 5
    var tamanho: Int = 8
    
    init(tamanho: Int) {
//        self.offset = offset
//        self.tamanho = tamanho
        
        grid = [[Cell]]()
        for x in 0...tamanho - 1 {
            grid.append([Cell]())
            for y in 0...tamanho - 1 {
                let cell = Cell(x: x, y: y)
                cell.position.x = x - offset
                cell.position.y = y - offset
                grid[x].append(Cell(x: x, y: y))
            }
        }
    }
    func acountNeighbours(cell: Cell) -> Int {
        var counterVizinho = 0
        var i = cell.position.x - 1
        
        while i <= cell.position.x + 1 {
            var j = cell.position.y - 1
            while Int(j) <= Int(cell.position.y + 1) {
                if !(cell.position.x == i && cell.position.y == j) && i >= 0 && j >= 0  && Int(j) < tamanho && Int(i) < tamanho {
                    
                    if grid[i][j].estado == .alive {
                        counterVizinho = counterVizinho + 1
                    }
                    
                }
                j += 1
            }
            i += 1
        }
        cell.aliveNeighbours = counterVizinho
        return counterVizinho
    }
    
    func updateGrid() {
        var newGrid = [[Cell]]()
        var count: Int
        
        for i in 0..<tamanho {
            newGrid.append([Cell]())
            for j in 0..<tamanho {
                let cell = grid[i][j]
                count = acountNeighbours(cell:  cell)
                
                let newCell = cell.copyCell()
                
                if newCell.estado == .alive {
                    if count <= 1 || count >= 4 {
                        newCell.estado = .dead
                    }
                }  else {
                    if count == 3 {
                        newCell.estado = .alive
                    }
                    
                }
                newGrid[i].append(newCell)
            }
        }
        grid = newGrid
        printGrid()
    }
    
    func printGrid(){
        for i in 0..<tamanho {
            for j in 0..<tamanho {
                if grid[i][j].estado == .alive {
                    print("1", separator: "", terminator: " ")
                } else {
                    print("0", separator: "", terminator: " ")
                }
            }
            print("")
        }
        print("")
    }
    
    
    
    //      func addNewRules(){
    //       rules.append(Rule(initialCellStatus: .alive, finalCellStatus: .dead, minCellNeighbours: 0, maxCellNeighbours: 1))
    //        rules.append(Rule(initialCellStatus: .alive, finalCellStatus: .dead, minCellNeighbours: 4, maxCellNeighbours: 8))
    //       rules.append(Rule(initialCellStatus: .alive, finalCellStatus: .alive, minCellNeighbours: 2, maxCellNeighbours: 3))
    //        rules.append(Rule(initialCellStatus: .dead, finalCellStatus: .alive, minCellNeighbours: 3, maxCellNeighbours: 3))
    //      }
    
}
