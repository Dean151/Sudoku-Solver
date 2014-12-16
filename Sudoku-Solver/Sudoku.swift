//
//  Sudoku.swift
//  Sudoku-Solver
//
//  Created by Thomas Durand on 15/12/2014.
//  Copyright (c) 2014 Dean151. All rights reserved.
//

import Darwin

class Sudoku: Printable {
    var cells: [[Int]]
    var length: Int
    
    var boxSize: Int {
        return Int(sqrt(Float(length)))
    }
    
    // Creating empty puzzle
    init(length: Int) {
        self.length = length
        
        var possibilities = [Int]()
        for i in 1...length {
            possibilities.append(i)
        }
        // We create an array of n*n values, each value have n possibilities
        self.cells = [[Int]](count: length*length, repeatedValue: possibilities)
    }
    
    
    // Copying puzzle
    init(puzzle: Sudoku) {
        self.length = puzzle.length
        self.cells = [[Int]](puzzle.cells)
    }
    
    // Creating puzzle from Array
    convenience init(values: [Int]) {
        self.init(length: Int(sqrt(Float(values.count))))
        
        for i in 0..<values.count {
            if values[i] > 0 && values[i] <= length {
                if let puzzle: Sudoku = Sudoku.placeValue(sudoku: self, cell: i, value: values[i]) {
                    self.cells = puzzle.cells
                } else {
                    println("This puzzle is unsolvable");
                }
            }
        }
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
    func peers(#cell: Int) -> [Int] {
        var peers = [Int]()
        
        for c in 0..<length*length {
            if isPeer(c1: cell, c2: c) {
                peers.append(c)
            }
        }
        
        return peers
    }
    
    // We place the known values
    class func placeValue(#sudoku: Sudoku, cell: Int, value: Int) -> Sudoku? {
        var puzzle = Sudoku(puzzle: sudoku)
        
        if !contains(puzzle.cells[cell], value) {
            return nil // If it is impossible to have this value here we rage quit
        }
        
        puzzle.cells[cell] = [Int]([value]) // We set the value
        
        var cellsToPlace = Dictionary<Int, Int>()
        
        for peer in puzzle.peers(cell: cell) {
            var newPossibilities = puzzle.cells[peer]
            // We remove the possibility of this value in each peer
            for (i,p) in enumerate(newPossibilities) {
                if p == value {
                    newPossibilities.removeAtIndex(i)
                    break
                }
            }
            
            if newPossibilities.count == 0 {
                // The puzzle is unresovable
                return nil
            }
            
            if newPossibilities.count == 1 && puzzle.cells[peer].count > 1 {
                // We add the cell in the queue for adding this value
                cellsToPlace.updateValue(newPossibilities.first!, forKey: peer)
            }
            
            // We record the newPossibilities
            puzzle.cells[peer] = newPossibilities
        }
        
        for (peer, value) in cellsToPlace {
            if let puzzle: Sudoku = placeValue(sudoku: puzzle, cell: peer, value: value) {
            } else {
                // Puzzle is unresovable
                return nil
            }
        }
        
        return puzzle
    }
    
    class func isSolved(#sudoku: Sudoku) -> Bool {
        for cell in sudoku.cells {
            if cell.count != 1 {
                return false
            }
        }
        return true
    }
    
    class func findWorkingCell(#sudoku: Sudoku) -> Int {
        var eligibles = Dictionary<Int, Int>()
        for (i,e) in enumerate(sudoku.cells) {
            if e.count > 1 {
                eligibles.updateValue(e.count, forKey: i)
            }
        }
        
        var min = 10
        var index = -1
        for (i,e) in eligibles {
            if e < min {
                min = e
                index = i
            }
        }
        
        return index
    }
    
    // The solver function
    class func solve(#sudoku: Sudoku) -> Sudoku? {
        
        if isSolved(sudoku: sudoku) {
            println("Sudoku is solved")
            return sudoku
        }
        
        let activeCell = findWorkingCell(sudoku: sudoku)
        if (activeCell >= 0) {
            for guess in sudoku.cells[activeCell] {
                if let puzzle = placeValue(sudoku: sudoku, cell: activeCell, value: guess) {
                    if let puzzle = solve(sudoku: puzzle) {
                        return puzzle
                    }
                }
            }
        }

        return nil
    }
    
    var description: String {
        var description = ""
        
        for (index,possibilities) in enumerate(cells) {
            if possibilities.count == 1 {
                let num: Int = possibilities.first!
                description += "\(num)"
            } else {
                description += "."
            }
            
            if (index%length == length-1) {
                description += "\n"
            }
        }
        
        return description
    }
}