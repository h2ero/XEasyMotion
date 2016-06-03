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
    
    func resizeWindow() -> Bool {
        window?.setFrame(NSRect.init(x: 0, y: 0, width: (NSScreen.mainScreen()?.frame.size.width)!, height: ((NSScreen.mainScreen()?.frame.height)!)), display: true)
        window?.center()
        return true
    }
    
}
