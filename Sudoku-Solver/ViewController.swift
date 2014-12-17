//
//  ViewController.swift
//  Sudoku-Solver
//
//  Created by Thomas Durand on 15/12/2014.
//  Copyright (c) 2014 Dean151. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var numberSelector: UISegmentedControl!
    @IBOutlet var grid: UIImageView!
    @IBOutlet var unsolvableLabel: UILabel!
    @IBOutlet var solvedLabel: UILabel!
    
    var labels: [MyLabel]!
    var numberSelected = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Setting up labels
        labels = [MyLabel]()
        for i in 0..<81 {
            let l = MyLabel(frame: CGRect(x: 0, y: 0, width: 70, height: 70))
            l.text = ".";
            l.textAlignment = NSTextAlignment.Center
            l.textColor = UIColor.grayColor()
            l.font = UIFont.systemFontOfSize(17)
            
            let x = (i%9)*35 + 19
            let y = Int(floor(Double(i)/9)*35) + 145
            
            l.center = CGPoint(x: x, y: y)
            
            labels.append(l)
            self.view.addSubview(l)
        }
    }
    
    // Should return a int between 0 and 80 if we click inside a cell, nil otherwise
    func getCell(point: CGPoint) -> Int? {
        if point.y > 120 && point.y < 440 {
            let cell = Int( floor((point.y-120)/36)*9 + floor((point.x-1)/36) )
            return cell
        } else {
            return nil
        }
    }
    
    // Change the number selected to assign it
    @IBAction func selectNumber(sender: AnyObject) {
        numberSelected = numberSelector.selectedSegmentIndex
    }
    
    // Change the number of a cell on a tap
    func changeNumber(index: Int) {
        if index >= 0 && index < labels.count {
            let label = labels[index] as MyLabel
            
            if numberSelected == 0 {
                label.value = 0
                label.text = "."
                label.textColor = UIColor.grayColor()
                label.font = UIFont.systemFontOfSize(17)
                
            } else if numberSelected > 0 && numberSelected <= 9 {
                label.value = numberSelected
                label.text = "\(label.value)"
                label.textColor = UIColor.blackColor()
                label.font = UIFont.boldSystemFontOfSize(17)
            }
        }
    }
    
    // Clear all numbers
    @IBAction func clearAll(sender: AnyObject) {
        unsolvableLabel.hidden = true
        solvedLabel.hidden = true
        for label in labels {
            label.text = "."
            label.textColor = UIColor.grayColor()
            label.font = UIFont.systemFontOfSize(17)
            label.value = 0
        }
    }
    
    // Solve the actual grid
    @IBAction func solveGrid(sender: AnyObject) {
        var numberToBePlaced = Dictionary<Int, Int>()
        unsolvableLabel.hidden = true
        solvedLabel.hidden = true
        
        var input = [Int](count: 81, repeatedValue: 0)
        for (i,label) in enumerate(labels) {
            if label.value != 0 { // Excluding the number we haven't entered
                input[i] = label.value
            }
        }
        
        let puzzle = Sudoku(values: input)
        if let solvedSudoku = Sudoku.solve(sudoku: puzzle) {
            if solvedSudoku.solvable {
                for (i,cell) in enumerate(solvedSudoku.cells) {
                    let label: UILabel = labels[i]
                    if let value:Int = cell.first {
                        label.text = "\(value)"
                    }
                }
                solvedLabel.hidden = false
            } else {
                unsolvableLabel.hidden = false
            }
        } else {
            unsolvableLabel.hidden = false
        }
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        if let touch: AnyObject = touches.anyObject() {
            let p = touch.locationInView(nil)
            if let index = getCell(p) {
                changeNumber(index)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

class MyLabel: UILabel {
    var value=0
}