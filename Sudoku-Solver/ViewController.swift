//
//  ViewController.swift
//  Sudoku-Solver
//
//  Created by Thomas Durand on 15/12/2014.
//  Copyright (c) 2014 Dean151. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var grid: UIImageView!
    var labels: [UILabel]!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Setting up labels
        labels = [UILabel]()
        for i in 0..<81 {
            let l = UILabel(frame: CGRect(x: 0, y: 0, width: 70, height: 70))
            l.text = ".";
            l.textAlignment = NSTextAlignment.Center
            l.textColor = UIColor.blackColor()
            
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
            let cell = Int( floor((point.y-120)/35)*9 + floor((point.x-1)/35) )
            return cell
        } else {
            return nil
        }
    }
    
    // Change the number of a cell on a tap
    func changeNumber(index: Int) {
        let label = labels[index] as UILabel
        if let value = label.text {
            if value == "9" {
                label.text = "."
            } else if value == "." {
                label.text = "1"
            } else {
                label.text = "\(value.toInt()! + 1)"
            }
        }
    }
    
    // Clear all numbers
    @IBAction func clearAll(sender: AnyObject) {
        for label in labels {
            label.text = "."
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