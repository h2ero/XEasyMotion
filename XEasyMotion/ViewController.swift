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
    }
    
    override func viewWillAppear() {
        gradView.layer?.backgroundColor = NSColor.clear.cgColor
    }

    override var representedObject: Any? {
        didSet {
        }
    }
    

}
