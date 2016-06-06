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
    
    static var startY:CGFloat = 0;
    override func windowDidLoad() {
        super.windowDidLoad()
    }
    
    static func resizeWindow(id:Int) {
        let windowFirst = Util.getWindowFirst()
        
        let hitChar = Constents.hintCharsKeyCodeMap[id]
        NSLog(hitChar!)
        var windowFrame = windowFirst.frame
        let oldWidth = windowFrame.size.width
        let oldHeight = windowFrame.size.height
        let toAdd = CGFloat(0.33333)
        let newWidth = oldWidth  * toAdd
        let newHeight = oldHeight * toAdd
        // get x , y
        windowFrame.size = NSMakeSize(newWidth, newHeight)
        (windowFrame.origin.x, windowFrame.origin.y) =  Util.getPostion(hitChar!, startX: (windowFrame.origin.x), startY: (windowFrame.origin.y), width: oldWidth, height: oldHeight)
        windowFirst.setFrame(windowFrame,display: true,animate: true)
        
    }
    
    static func maxWindow() {
        let windowFirst = Util.getWindowFirst()
        var windowFrame = windowFirst.frame
        windowFrame.size =  NSScreen.mainScreen()!.frame.size
        windowFrame.origin  = NSMakePoint(0, 0)
        
        windowFirst.setFrame(windowFrame,display: true)
        windowFirst.orderFront(self)
        windowFirst.center()
    }
    
    static func hideWindow(){
        let windowFirst = Util.getWindowFirst()
        windowFirst.setIsVisible(false)
        windowFirst.orderOut(self)
    }
    
    static func getWinCenterPoint() -> (CGFloat,CGFloat){
        let windowFirst = Util.getWindowFirst()
        let x = (windowFirst.frame.origin.x)  + ((windowFirst.frame.size.width) / 2 )
        let y = (windowFirst.frame.origin.y) + ((windowFirst.frame.size.height) / 2 )
        Log.write(Log.INFO, catelog: "nomarl", value: "win center: x:\(x), \(y)")
        return (CGFloat(x) , CGFloat(y))
    }
    
}