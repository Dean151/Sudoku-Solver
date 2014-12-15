//
//  Sudoku_SolverTests.swift
//  Sudoku-SolverTests
//
//  Created by Thomas Durand on 15/12/2014.
//  Copyright (c) 2014 Dean151. All rights reserved.
//

import UIKit
import XCTest

import Sudoku_Solver

class Sudoku_SolverTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    /*
    func TestPeers() {
        // FIXME import Sudoku.swift somehow...
        var p = Sudoku(length: 9);
        var peers = p.getPeers(cell: 40);
        
        var expectedResult: [Int] = [4, 13, 22, 30, 31, 32, 36, 37, 38, 39, 41, 42, 43, 44, 48, 49, 50, 58, 67, 76]
        XCTAssert(peers == expectedResult, "OK for Peers")
    }
    
    func TestSolver() {
        var p = Sudoku(values: [
            0, 0, 3, 0, 2, 0, 6, 0, 0,
            9, 0, 0, 3, 0, 5, 0, 0, 1,
            0, 0, 1, 8, 0, 6, 4, 0, 0,
            0, 0, 8, 1, 0, 2, 9, 0, 0,
            7, 0, 0, 0, 0, 0, 0, 0, 8,
            0, 0, 6, 7, 0, 8, 2, 0, 0,
            0, 0, 2, 6, 0, 9, 5, 0, 0,
            8, 0, 0, 2, 0, 3, 0, 0, 9,
            0, 0, 5, 0, 1, 0, 3, 0, 0
            ])
        var solution = [
            4, 8, 3, 9, 2, 1, 6, 5, 7,
            9, 6, 7, 3, 4, 5, 8, 2, 1,
            2, 5, 1, 8, 7, 6, 4, 9, 3,
            5, 4, 8, 1, 3, 2, 9, 7, 6,
            7, 2, 9, 5, 6, 4, 1, 3, 8,
            1, 3, 6, 7, 9, 8, 2, 4, 5,
            3, 7, 2, 6, 8, 9, 5, 1, 4,
            8, 1, 4, 2, 5, 3, 7, 6, 9,
            6, 9, 5, 4, 1, 7, 3, 8, 2
        ]
        
        let solved = p.solve(sudoku: p)
    }
    */
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
