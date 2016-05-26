//
//  ViewController.swift
//  keynav
//
//  Created by h2ero on 5/26/16.
//  Copyright © 2016 h2ero. All rights reserved.
//

import Cocoa
import AppKit

class ViewController: NSViewController  {

    @IBOutlet var gradView: NSView!
    override func viewDidLoad() {
        super.viewDidLoad()
            self.view.wantsLayer = true


        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear() {
        gradView.layer?.backgroundColor = NSColor.clearColor().CGColor
        //box.layer?.setNeedsDisplay()
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        gradView.layer?.backgroundColor = NSColor.blueColor().CGColor
            let backgroundColor = NSColor.whiteColor()
        backgroundColor.setFill()
        NSRectFill(NSMakeRect(0, 20, 300.0, 178.0))
        
        NSColor.redColor().setStroke()
        NSColor.magentaColor().setFill()
        //空のベジェパスを作成
        let aBezier : NSBezierPath = NSBezierPath()
        aBezier.moveToPoint(CGPoint(x: 176.95,y: 44.90))
        aBezier.curveToPoint(CGPoint(x: 166.71,y: 145.89),
                             controlPoint1: CGPoint(x: 76.63,y: 76.78),
                             controlPoint2: CGPoint(x: 82.59,y: 206.70))
        aBezier.curveToPoint(CGPoint(x: 176.95,y: 44.90),
                             controlPoint1: CGPoint(x: 237.55,y: 224.76),
                             controlPoint2: CGPoint(x: 276.83,y: 95.98))
        aBezier.closePath()
        aBezier.fill()
        aBezier.lineWidth = 2.0
        aBezier.stroke()
        
        }
    }
    

}

