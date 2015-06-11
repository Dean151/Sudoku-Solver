//
//  ViewController.swift
//  Sudoku-Solver
//
//  Created by Thomas Durand on 15/12/2014.
//  Copyright (c) 2014 Dean151. All rights reserved.
//

import UIKit
import iAd

class ViewController: UIViewController, ADBannerViewDelegate {
    
    @IBOutlet weak var numberSelector: UISegmentedControl!
    @IBOutlet var grid: UIImageView!
    @IBOutlet var solvedLabel: UILabel!
    
    // iAd
    var adBannerView: ADBannerView!
    
    var labels: [MyLabel]!
    var numberSelected = 1

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
            
            let x = (i%9)*35 + 21
            let y = Int(floor(Double(i)/9)*35) + 134
            
            l.center = CGPoint(x: x, y: y)
            
            labels.append(l)
            self.view.addSubview(l)
        }
        
        // Setting up iAd
        self.loadAds()
    }
    
    // Setting up iAd
    func loadAds() {
        adBannerView = ADBannerView(frame: CGRect.zeroRect)
        adBannerView.center = CGPoint(x: adBannerView.center.x, y: view.bounds.size.height - adBannerView.frame.size.height / 2)
        adBannerView.delegate = self
        adBannerView.hidden = true
        view.addSubview(adBannerView)
    }
    
    func bannerViewDidLoadAd(banner: ADBannerView!) {
        adBannerView.hidden = false
    }
    
    func bannerView(banner: ADBannerView!, didFailToReceiveAdWithError error: NSError!) {
        adBannerView.hidden = true
    }
    
    // Should return a int between 0 and 80 if we click inside a cell, nil otherwise
    func getCell(point: CGPoint) -> Int? {
        if point.y > 107 && point.y < 427 {
            let cell = Int( floor((point.y-107)/36)*9 + floor((point.x-1)/36) )
            return cell
        } else {
            return nil
        }
    }
    
    // Change the number selected to assign it
    @IBAction func selectNumber(sender: AnyObject) {
        if numberSelector.selectedSegmentIndex >= 0 && numberSelector.selectedSegmentIndex < 9 {
            numberSelected = numberSelector.selectedSegmentIndex + 1
        } else {
            numberSelected = 0
        }
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
                alertUnsolvable()
            }
        } else {
            alertUnsolvable()
        }
    }
    
    // Display an alert saying the puzzle is unsolvable
    func alertUnsolvable() {
        let alertController = UIAlertController(title: "Unsolvable", message:
            "Sorry, this puzzle is unsolvable !", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        if let touch: AnyObject = touches.first {
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