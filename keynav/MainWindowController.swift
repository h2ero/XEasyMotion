//
//  MainWindowController.swift
//  keynav
//
//  Created by h2ero on 5/26/16.
//  Copyright © 2016 h2ero. All rights reserved.
//

import Foundation

import Cocoa

class MainWindowController: NSWindowController {
    
    override func windowDidLoad() {
        super.windowDidLoad()
        // max
        self.resizeWindow()
        
    }
    
    func resizeWindow() {
        window?.setFrame(NSRect.init(x: 0, y: 0, width: (NSScreen.screens()![0].frame.size.width), height: ((NSScreen.mainScreen()!.frame.size.height))), display: true)
        window?.backgroundColor = NSColor.clearColor()
    }
    
}
