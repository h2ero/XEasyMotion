
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
    static var positionHistory : [(x:CGFloat, y:CGFloat, width:CGFloat, height:CGFloat)] = []
    static var clickHistory : [(x:CGFloat, y:CGFloat, width:CGFloat, height:CGFloat)] = []
    static var clickHistoryTraversal : [(x:CGFloat, y:CGFloat, width:CGFloat, height:CGFloat)] = []
    
    static func addActiveKeyBind()  {
        NSLog("add active Key bind")
        HotKeys.register(keycode: UInt32(kVK_ANSI_I), modifiers: UInt32(cmdKey), block:{_ in
            self.positionHistory = []
            self.maxWindow()
            self.addHitKeyBind()
            self.addRestoreKeyBind()
            self.addClickBinds()
            self.addMoveKeyBind()
            self.addCancelKeyBind()
            self.addGoToPreviousClickPositionKeyBind()
        })
    }
    
    class func addHitKeyBind() {}
    class func addClickBinds() {}
    class func addMoveKeyBind(){}
    class func removeKeyBind(){}
    
    static func addRestoreKeyBind() {
        HotKeys.register(keycode: UInt32(kVK_ANSI_U), modifiers: UInt32(activeFlag), block:{
            (id:EventHotKeyID) in
            self.goToPreviousPosition()
        })
    }
    
    static func addGoToPreviousClickPositionKeyBind() {
        HotKeys.register(keycode: UInt32(kVK_ANSI_O), modifiers: UInt32(controlKey), block:{
            (id:EventHotKeyID) in
            self.goToPreviousClickPosition()
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
        
        // Restores the click history and clear the traversal
        self.clickHistory.append(contentsOf: self.clickHistoryTraversal.reversed())
        self.clickHistoryTraversal = []
    }
    
    static func getWinCenterPoint() -> (CGFloat,CGFloat){
        let windowFrame = getWindowFrame()
        let x = (windowFrame.origin.x)  + ((windowFrame.size.width) / 2 )
        let y = (windowFrame.origin.y) + ((windowFrame.size.height) / 2 )
//        Log.write(errLevel: Log.INFO, catelog: "nomarl", value: "win center: x:\(x), \(y)" as AnyObject)
        return (CGFloat(x) , CGFloat(y))
    }
    
    static func moveWindow(dirction:Int){
        self.addLastPosition()
        var windowFrame = getWindowFrame()

        if  dirction - shiftKey == Constents.moveKeyCode["LEFT"]  {
            windowFrame.origin.x = windowFrame.origin.x - windowFrame.size.width
        }else if  dirction - shiftKey  == Constents.moveKeyCode["RIGHT"]  {
            windowFrame.origin.x = windowFrame.origin.x + windowFrame.size.width
        }else if  dirction - shiftKey  == Constents.moveKeyCode["UP"]  {
            windowFrame.origin.y = windowFrame.origin.y + windowFrame.size.height
        }else if  dirction - shiftKey  == Constents.moveKeyCode["DOWN"]  {
            windowFrame.origin.y = windowFrame.origin.y - windowFrame.size.height
        }
        Util.getWindowFirst().setFrame(windowFrame,display: true,animate: Constents.animation)
    }
    
    static func addLastPosition(){
        self.positionHistory.append(getPosition())
//        Log.write(errLevel: Log.INFO, catelog: "postion", value: self.postionStack.count)
    }
    
    static func addLastClickPosition(){
        // If click history contains less than 10 clicks
        if self.clickHistory.count < 10 {
            let position = getPosition()
            // If first click or last click is not the same as the previous click, add click
            if self.clickHistory.isEmpty || position != self.clickHistory.last! {
                self.clickHistory.append(position)
            }
        } else { // otherwise remove the earliest click and add the latest
            self.clickHistory.remove(at: 0)
            addLastClickPosition()
        }
//        Log.write(errLevel: Log.INFO, catelog: "postion", value: self.postionStack.count)
    }
    
    private static func getPosition() -> (x:CGFloat, y:CGFloat, width:CGFloat, height:CGFloat) {
        var windowFrame = getWindowFrame()
        return (windowFrame.origin.x, y: windowFrame.origin.y, width: windowFrame.size.width, height: windowFrame.size.height)
    }
    
    static func goToPreviousPosition(){
        if let positionInfo = self.positionHistory.popLast() {
            goToPosition(positionInfo: positionInfo)
        }
    }
    
    static func goToPreviousClickPosition() {
        if let positionInfo = self.clickHistory.popLast() {
            self.clickHistoryTraversal.append(positionInfo)
            goToPosition(positionInfo: positionInfo)
        }
    }
    
    private static func getWindowFrame() -> NSRect {
        return Util.getWindowFirst().frame
    }
    
    private static func goToPosition(positionInfo: (x:CGFloat, y:CGFloat, width:CGFloat, height:CGFloat)) {
        var windowFrame = getWindowFrame()
        
        windowFrame.origin.y = positionInfo.y
        windowFrame.origin.x = positionInfo.x
        
        windowFrame.size.width = positionInfo.width
        windowFrame.size.height = positionInfo.height
        
        Util.getWindowFirst().setFrame(windowFrame ,display: true, animate: Constents.animation)
    }
   
}
