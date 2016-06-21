//
//  NineBlockBox.swift
//  XEasyMotion
//
//  Created by h2ero on 6/21/16.
//  Copyright © 2016 h2ero. All rights reserved.
//

import Foundation
import Carbon

class NineBlockMode: Mode {
    static func load(){
        self.addActiveKeyBind()
        self.addHitKeyBind()
        self.addClickBind()
        self.addMoveKeyBind()
        self.addCancelKeyBind()
    }
    
    static func addActiveKeyBind()  {
        HotKeys.register(UInt32(kVK_ANSI_I), modifiers: UInt32(cmdKey), block:{_ in
            self.maxWindow()
            self.addHitKeyBind()
            self.addClickBind()
            self.addMoveKeyBind()
            self.addCancelKeyBind()
        })
    }
    
    static func addHitKeyBind()  {
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
    
    static func addMoveKeyBind()  {
        for (_, keyCode) in Constents.moveKeyCode {
            Log.write(Log.INFO, catelog: "register key code", value: keyCode)
            HotKeys.register(UInt32(keyCode), modifiers: UInt32(shiftKey), block:{
                (id:EventHotKeyID) in
                Log.write(Log.INFO, catelog: "move", value: String(id.id))
                self.moveWindow(Int(id.id))
            })
        }
        
    }
    
    static func addClickBind()  {
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
    }
    static func draw(){
        GradView.drawHorizLine(1/3.0)
        GradView.drawHorizLine(2/3.0)
        GradView.drawVertLine(1/3.0)
        GradView.drawVertLine(2/3.0)
        // draw chars
        let size = GradView.getSize()
        let xAxis:[CGFloat] = [
            size.width / 6,
            size.width / 6 * 3,
            size.width / 6 * 5
        ]
        let yAxis:[CGFloat] = [
            size.height / 6 * 5,
            size.height / 6 * 3,
            size.height / 6
        ]
        
        for (y, row) in Constents.hintChars.enumerate(){
            for(x, hintChar) in row.enumerate(){
                GradView.drawChar(hintChar, x:  xAxis[x] - (GradView.getHintCharFontSize()/2), y: yAxis[y] - (GradView.getHintCharFontSize() / 2))
            }
        }
    }
    
    static func resizeWindow(id:Int) {
        let windowFirst = Util.getWindowFirst()
        var windowFrame = windowFirst.frame
        
        let hitChar = Constents.hintCharsKeyCodeMap[id - activeFlag]
        Log.write(Log.INFO, catelog: "resize", value: hitChar!)
        let oldWidth = windowFrame.size.width
        let oldHeight = windowFrame.size.height
        let toAdd = CGFloat(0.33333)
        let newWidth = oldWidth  * toAdd
        let newHeight = oldHeight * toAdd
        // get x , y
        windowFrame.size = NSMakeSize(newWidth, newHeight)
        (windowFrame.origin.x, windowFrame.origin.y) =  Util.getPostion(hitChar!, startX: (windowFrame.origin.x), startY: (windowFrame.origin.y), width: oldWidth, height: oldHeight)
        windowFirst.setFrame(windowFrame,display: true,animate: Constents.animation)
    }
    
}