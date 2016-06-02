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
//            self.view.wantsLayer = true


        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear() {
        //gradView.layer?.backgroundColor = NSColor.clearColor().CGColor
        //box.layer?.setNeedsDisplay()
        // Update the view, if already loaded.
        //gradView.layer?.backgroundColor = NSColor.blueColor().CGColor

        
    }

    override var representedObject: AnyObject? {
        didSet {
        }
    }
    

}