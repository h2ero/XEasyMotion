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
        self.maxWindow()
        
    }
    
    static func resizeWindow(id:Int) {
        let windowFirst = NSApplication.sharedApplication().windows.first
        let hitChar = Constents.hintCharsKeyCodeMap[id]
        NSLog(hitChar!)
        var windowFrame = windowFirst?.frame
        let oldWidth = windowFrame!.size.width
        let oldHeight = windowFrame!.size.height
        let toAdd = CGFloat(0.33333)
        let newWidth = oldWidth  * toAdd
        let newHeight = oldHeight * toAdd
        // get x , y
        windowFrame!.size = NSMakeSize(newWidth, newHeight)
        (windowFrame!.origin.x, windowFrame!.origin.y) =  Util.getPostion(hitChar!, startX: (windowFrame?.origin.x)!, startY: (windowFrame?.origin.y)!, width: oldWidth, height: oldHeight)
        windowFirst?.setFrame(windowFrame!,display: true,animate: true)
    }
    
    func maxWindow() {
        window?.setFrame(NSRect.init(x: 0, y: 0, width: (NSScreen.screens()![0].frame.size.width), height: ((NSScreen.mainScreen()!.frame.size.height))), display: true)
        window?.backgroundColor = NSColor.clearColor()
                window?.orderOut(self)
        window?.center()
    }
}
