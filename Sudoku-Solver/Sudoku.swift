//
//  Sudoku.swift
//  Sudoku-Solver
//
//  Created by Thomas Durand on 15/12/2014.
//  Copyright (c) 2014 Dean151. All rights reserved.
//

import Darwin

class Sudoku {
    var cells: [[Int]]
    var length: Int
    
    var boxSize: Int {
        return Int(sqrt(Float(length)))
    }
    
    init(length: Int) {
        self.length = length
        
        var possibilities = [Int]()
        for i in 1...length {
            possibilities.append(i)
        }
        // We create an array of n*n values, each value have n possibilities
        self.cells = [[Int]](count: length*length, repeatedValue: possibilities)
    }
    
    init(puzzle: Sudoku) {
       self.length = puzzle.length
       self.cells = [[Int]](puzzle.cells)
    }
    
    // The peers are the cells that are in the same row, square or column. They can not be equals in value !
    func isPeer(#c1: Int, c2: Int) -> Bool {
        return (c1 / length == c2 / length            //Cells in same row
                    || c1 % length == c2 % length     //Cells in same column
                    || (c1 / length / boxSize == c2 / length / boxSize && c1 % length / boxSize == c2 % length / boxSize))
                                                      //Cells in same box
                    && c1 != c2;                      //Cell is not peer to itself
    }
    
    // Allow to get all peers for a single cell, with are all cells in the same row, column or square.
    func getPeers(#cell: Int) -> [Int] {
        var peers = [Int]()
        
        for c in 0..<length*length {
            if isPeer(c1: cell, c2: c) {
                peers.append(c)
            }
        }
        
        return peers
    }
}