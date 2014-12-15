//
//  Sudoku_SolverTests.swift
//  Sudoku-SolverTests
//
//  Created by Thomas Durand on 15/12/2014.
//  Copyright (c) 2014 Dean151. All rights reserved.
//

import UIKit
import XCTest

class Sudoku_SolverTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func TestPeers() {
        // FIXME import Sudoku.swift somehow...
        var p = Sudoku(length: 9);
        var peers = p.getPeers(cell: 40);
        
        var expectedResult: [Int] = [4, 13, 22, 30, 31, 32, 36, 37, 38, 39, 41, 42, 43, 44, 48, 49, 50, 58, 67, 76]
        XCTAssert(peers == expectedResult, "OK for Peers")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
