//
//  ViewController.swift
//  Sudoku-Solver
//
//  Created by Thomas Durand on 15/12/2014.
//  Copyright (c) 2014 Dean151. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}