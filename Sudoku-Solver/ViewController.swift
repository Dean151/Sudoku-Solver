//
//  ViewController.swift
//  Sudoku-Solver
//
//  Created by Thomas Durand on 15/12/2014.
//  Copyright (c) 2014 Dean151. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Test sudoku
        let sudoku = Sudoku(values: [
            0, 0, 3, 0, 2, 0, 6, 0, 0,
            9, 0, 0, 3, 0, 5, 0, 0, 1,
            0, 0, 1, 8, 0, 6, 4, 0, 0,
            0, 0, 8, 1, 0, 2, 9, 0, 0,
            7, 0, 0, 0, 0, 0, 0, 0, 8,
            0, 0, 6, 7, 0, 8, 2, 0, 0,
            0, 0, 2, 6, 0, 9, 5, 0, 0,
            8, 0, 0, 2, 0, 3, 0, 0, 9,
            0, 0, 5, 0, 1, 0, 3, 0, 0
            ]);
        println(sudoku)
        println(Sudoku.solve(sudoku: sudoku))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

