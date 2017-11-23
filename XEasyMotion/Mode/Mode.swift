
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
    static var postionStack : [(x:CGFloat, y:CGFloat, width:CGFloat, height:CGFloat)] = []
    
    static func addActiveKeyBind()  {
        NSLog("add active Key bind")
        HotKeys.register(keycode: UInt32(kVK_ANSI_I), modifiers: UInt32(cmdKey), block:{_ in
            self.postionStack = []
            self.maxWindow()
            self.addHitKeyBind()
            self.addRestoreKeyBind()
            self.addClickBind()
            self.addMoveKeyBind()
            self.addCancelKeyBind()
        })
    }
    
    class func addHitKeyBind() {}
    class func addClickBind() {}
    class func addMoveKeyBind(){}
    class func removeKeyBind(){}
    
    static func addRestoreKeyBind() {
        HotKeys.register(keycode: UInt32(kVK_ANSI_U), modifiers: UInt32(activeFlag), block:{
            (id:EventHotKeyID) in
            self.restoreWindow()
        })
    }
    
    static func addCancelKeyBind() {
        HotKeys.register(keycode: UInt32(kVK_Escape), modifiers: UInt32(activeFlag), block:{
            (id:EventHotKeyID) in
            NSLog("cancel")

            self.hideWindow()
            self.removeKeyBind()
            
//            Keybind.removeKeyBind();
        })
    }
      static func maxWindow() {
        let windowFirst = Util.getWindowFirst()
        var windowFrame = windowFirst.frame
        windowFrame.size =  NSScreen.main!.frame.size
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
//        Log.write(errLevel: Log.INFO, catelog: "nomarl", value: "win center: x:\(x), \(y)" as AnyObject)
        return (CGFloat(x) , CGFloat(y))
    }
    
    static func moveWindow(dirction:Int){
        self.addPostionStack()
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
    
    static func addPostionStack(){
        let windowFirst = Util.getWindowFirst()
        let windowFrame = windowFirst.frame
        let potionInfo = (windowFrame.origin.x, y: windowFrame.origin.y, width: windowFrame.size.width, height: windowFrame.size.height)
        self.postionStack.append(potionInfo)
//        Log.write(errLevel: Log.INFO, catelog: "postion", value: self.postionStack.count)
    }
    
    static func restoreWindow(){
        let windowFirst = Util.getWindowFirst()
        var windowFrame = windowFirst.frame
        if self.postionStack.count > 0 {
            let potionInfo = self.postionStack.popLast()
            
            windowFrame.origin.y = potionInfo!.y
            windowFrame.origin.x = potionInfo!.x
            
            windowFrame.size.width = potionInfo!.width
            windowFrame.size.height = potionInfo!.height
            
            windowFirst.setFrame(windowFrame,display: true,animate: Constents.animation)
        }
    }
   
}
