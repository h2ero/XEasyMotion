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
    
    
        var frame = NSScreen.mainScreen()?.frame
    override func windowDidLoad() {
        super.windowDidLoad()
        // max
        self.maxWindow()
    }
    func resizeWindow(hintChar:String) {
        var windowFrame = self.frame
        let oldWidth = windowFrame!.size.width
        let oldHeight = windowFrame!.size.height
        let toAdd = CGFloat(0.3333333)
        let newWidth = oldWidth  * toAdd
        let newHeight = oldHeight * toAdd
        windowFrame!.size = NSMakeSize(newWidth, newHeight)
        self.frame  = windowFrame
        window?.setFrame(self.frame!,display: true)
    }
    
    func maxWindow() {
        window?.setFrame(NSRect.init(x: 0, y: 0, width: (NSScreen.screens()![0].frame.size.width), height: ((NSScreen.mainScreen()!.frame.size.height))), display: true)
        window?.backgroundColor = NSColor.clearColor()
        window?.orderOut(self)
    }
}
