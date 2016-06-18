//
//  MainWindowController.swift
//  keynav
//
//  Created by h2ero on 5/26/16.
//  Copyright © 2016 h2ero. All rights reserved.
//

import Foundation

import Cocoa
import Carbon

class MainWindowController: NSWindowController {
    
    static var startY:CGFloat = 0;
    override func windowDidLoad() {
        super.windowDidLoad()
    }
    
    static func resizeWindow(id:Int) {
        let windowFirst = Util.getWindowFirst()
        var windowFrame = windowFirst.frame
        
        let hitChar = Constents.hintCharsKeyCodeMap[id - activeFlag]
        NSLog(hitChar!)
        if Constents.mode == Constents.modeHintChars {
            let oldWidth = windowFrame.size.width
            let oldHeight = windowFrame.size.height
            let toAdd = CGFloat(0.33333)
            let newWidth = oldWidth  * toAdd
            let newHeight = oldHeight * toAdd
            // get x , y
            windowFrame.size = NSMakeSize(newWidth, newHeight)
            (windowFrame.origin.x, windowFrame.origin.y) =  Util.getPostion(hitChar!, startX: (windowFrame.origin.x), startY: (windowFrame.origin.y), width: oldWidth, height: oldHeight)
        } else {
            let oldWidth = windowFrame.size.width
            let oldHeight = windowFrame.size.height
            var newWidth = oldWidth
            var newHeight = oldHeight
            if hitChar == "H" {
                newWidth = oldWidth  * 0.5
            } else if hitChar == "L" {
                newWidth = oldWidth  * 0.5
                windowFrame.origin.x += newWidth
            } else if hitChar == "K" {
                newHeight = oldHeight  * 0.5
                windowFrame.origin.y += newHeight
            } else {
                newHeight = oldHeight  * 0.5
            }
            windowFrame.size = NSMakeSize(newWidth, newHeight)
        }
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
    
    static func moveWindow(dirction:Int){
        let windowFirst = Util.getWindowFirst()
        var windowFrame = windowFirst.frame
        
        if  dirction - shiftKey == Constents.moveKeyCode["LEFT"]  {
            windowFrame.origin.x = windowFrame.origin.x - windowFrame.size.width
        }else if  dirction - shiftKey  == Constents.moveKeyCode["RIGHT"]  {
            windowFrame.origin.x = windowFrame.origin.x + windowFrame.size.width
        }else if  dirction - shiftKey  == Constents.moveKeyCode["UP"]  {
            windowFrame.origin.y = windowFrame.origin.y + windowFrame.size.height
        }else if  dirction - shiftKey  == Constents.moveKeyCode["DOWN"]  {
            windowFrame.origin.y = windowFrame.origin.y - windowFrame.size.height
        }
        windowFirst.setFrame(windowFrame,display: true,animate: true)
    }
    
}