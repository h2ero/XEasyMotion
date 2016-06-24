//
//  self.swift
//  XEasyMotion
//
//  Created by h2ero on 6/19/16.
//  Copyright © 2016 h2ero. All rights reserved.
//

import Foundation
import Carbon

class SimpleMode : Mode{
    
    static func load(){
        self.addActiveKeyBind()
        self.addRestoreKeyBind()
        self.addHitKeyBind()
        self.addClickBind()
        self.addMoveKeyBind()
        self.addCancelKeyBind()
    }
    
    override static func addHitKeyBind()  {
        Log.write(Log.INFO, catelog: "register key code", value: "start")
        for (keyCode, _) in Constents.hintCharsKeyCodeMap{
            Log.write(Log.INFO, catelog: "register key code", value: keyCode)
            HotKeys.register(UInt32(keyCode), modifiers: UInt32(activeFlag), block:{
                (id:EventHotKeyID) in self.resizeWindow(Int(id.id))
                //                let (x,y) = self.getWinCenterPoint()
                //                Util.moveMouse(x, y: y)
            })
        }
        Log.write(Log.INFO, catelog: "register key code", value: "end")
    }
    
    override static func addMoveKeyBind()  {
        for (_, keyCode) in Constents.moveKeyCode {
            Log.write(Log.INFO, catelog: "register key code", value: keyCode)
            HotKeys.register(UInt32(keyCode), modifiers: UInt32(shiftKey), block:{
                (id:EventHotKeyID) in
                Log.write(Log.INFO, catelog: "move", value: String(id.id))
                self.moveWindow(Int(id.id))
            })
        }
        
    }
    
    override static func addClickBind()  {
        HotKeys.register(UInt32(kVK_Return), modifiers: UInt32(activeFlag), block:{_ in
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                // do some async stuff
                let (x,y) = self.getWinCenterPoint()
                self.hideWindow()
                self.removeKeyBind();
                NSOperationQueue.mainQueue().addOperationWithBlock {
                    // do some main thread stuff stuff
                    Util.click(x, y: y)
                }
            }
            
        });
        
        HotKeys.register(UInt32(kVK_Return), modifiers: UInt32(shiftKey), block:{_ in
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                let (x,y) = self.getWinCenterPoint()
                self.hideWindow()
                self.removeKeyBind();
                NSOperationQueue.mainQueue().addOperationWithBlock {
                    Util.rightClick(x, y: y)
                }
            }
        });
    }
    static func removeKeyBind(){
        for (keyCode, _) in Constents.hintCharsKeyCodeMap{
            HotKeys.unregister(UInt32(keyCode + activeFlag))
        }
        
        
        for ( _,keyCode) in Constents.moveKeyCode {
            Log.write(Log.INFO, catelog: "remove move key", value: String(UInt32(keyCode + shiftKey)))
            HotKeys.unregister(UInt32(keyCode + shiftKey))
        }
        
        HotKeys.unregister(UInt32(kVK_Return + activeFlag))
        HotKeys.unregister(UInt32(kVK_Return + shiftKey))
        HotKeys.unregister(UInt32(kVK_Escape + activeFlag))
        HotKeys.unregister(UInt32(kVK_ANSI_U + activeFlag))
    }
    static func draw(){
        GradView.drawHorizLine(0)
        GradView.drawHorizLine(1/2.0)
        GradView.drawHorizLine(1.0)
        GradView.drawVertLine(0)
        GradView.drawVertLine(1/2.0)
        GradView.drawVertLine(1.0)
    }
    
    static func resizeWindow(id:Int) {
        self.addPostionStack()
        let windowFirst = Util.getWindowFirst()
        var windowFrame = windowFirst.frame
        
        let hitChar = Constents.hintCharsKeyCodeMap[id - activeFlag]
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
        windowFirst.setFrame(windowFrame,display: true,animate: Constents.animation)
        
    }
    
    
    
}