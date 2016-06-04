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
//        self.maxWindow()
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
    
    static func maxWindow() {
        let windowFirst = NSApplication.sharedApplication().windows.first
        var windowFrame = windowFirst?.frame
        windowFrame!.size =  NSScreen.screens()![0].frame.size
        windowFrame!.origin  = NSMakePoint(0, 0)
        windowFirst?.setFrame(windowFrame!,display: true)
        windowFirst?.center()
    }
    
    static func hideWindow(){
        let windowFirst = NSApplication.sharedApplication().windows.first
        windowFirst?.orderOut(self)
    }
    
    static func getWinCenterPoint() -> (CGFloat,CGFloat){
        let windowFirst = NSApplication.sharedApplication().windows.first
        let x = (windowFirst?.frame.origin.x)!  + ((windowFirst?.frame.size.width)! / 2 )
        let y = (windowFirst?.frame.origin.y)! + ((windowFirst?.frame.size.height)! / 2 )
        NSLog(String(x))
        NSLog(String(y))
        return (CGFloat(x) , CGFloat(y))
    }
}
