
//  Mode.swift
//  XEasyMotion
//
//  Created by h2ero on 6/19/16.
//  Copyright © 2016 h2ero. All rights reserved.
//

import Foundation
import Carbon
import Cocoa

class Mode {
    static var startY:CGFloat = 0;
    
    static func addCancelKeyBind() {
        HotKeys.register(UInt32(kVK_Escape), modifiers: UInt32(activeFlag), block:{
            (id:EventHotKeyID) in
            self.hideWindow()
//            Keybind.removeKeyBind();
        })
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
        windowFirst.setFrame(windowFrame,display: true,animate: Constents.animation)
    }
}