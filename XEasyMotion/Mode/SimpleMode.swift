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
        self.addClickBinds()
        self.addHoverCursorBind()
        self.addMoveKeyBind()
        self.addCancelKeyBind()
    }
    
    override static func addHitKeyBind()  {
//        Log.write(errLevel: Log.INFO, catelog: "register key code", value: "start")
        for (keyCode, _) in Constents.hintCharsKeyCodeMap{
//            Log.write(Log.INFO, catelog: "register key code", value: keyCode)
            HotKeys.register(keycode: UInt32(keyCode), modifiers: UInt32(activeFlag), block:{
                (id:EventHotKeyID) in self.resizeWindow(id: Int(id.id))
                //                let (x,y) = self.getWinCenterPoint()
                //                Util.moveMouse(x, y: y)
            })
        }
//        Log.write(Log.INFO, catelog: "register key code", value: "end")
    }
    
    override static func addMoveKeyBind()  {
        for (_, keyCode) in Constents.moveKeyCode {
//            Log.write(Log.INFO, catelog: "register key code", value: keyCode)
            HotKeys.register(keycode: UInt32(keyCode), modifiers: UInt32(shiftKey), block:{
                (id:EventHotKeyID) in
//                Log.write(errLevel: Log.INFO, catelog: "move", value: String(id.id) as AnyObject)
                self.moveWindow(dirction: Int(id.id))
            })
        }
        
    }
    
    override static func addClickBinds() {
        HotKeys.register(keycode: UInt32(kVK_Return), modifiers: UInt32(activeFlag), block:{_ in
            performClick(clickFunc: Util.click)
        });
        
        print("register click")
        HotKeys.register(keycode: UInt32(kVK_ANSI_C), modifiers: UInt32(activeFlag), block:{_ in
            print("doubleClick")
            performClick(clickFunc: Util.doubleClick)
        });

        
        HotKeys.register(keycode: UInt32(kVK_Return), modifiers: UInt32(shiftKey), block:{_ in
            performClick(clickFunc: Util.rightClick)
        });
    }
    
    override static func addHoverCursorBind()  {
        HotKeys.register(keycode: UInt32(kVK_ANSI_I), modifiers: UInt32(activeFlag), block:{_ in
            DispatchQueue.global().async {
                let (x,y) = self.getWinCenterPoint()
                DispatchQueue.global().async{
                    Util.hoverMouse(x: x, y: y)
                }
            }
        });
        
        // Binds Space to click without dismissing the grid.
        HotKeys.register(keycode: UInt32(kVK_Space), modifiers: UInt32(activeFlag), block:{_ in
            DispatchQueue.global().async {
                let (x,y) = self.getWinCenterPoint()
                self.hideWindow()
                DispatchQueue.main.async{
                    Util.click(x: x, y: y)
                    self.showWindow()
                }
            }
            
        });
    }
    
    
    private static func performClick(clickFunc: @escaping (CGFloat, CGFloat) -> Void) {
        DispatchQueue.global().async {
            self.addLastClickPosition()
            let (x,y) = self.getWinCenterPoint()
            //  print
            print("hide window")
            self.removeKeyBind();
            DispatchQueue.main.async{
                clickFunc(x, y)
                self.hideWindow()
            }
        }
    }
    
    override static func removeKeyBind(){
        for (keyCode, _) in Constents.hintCharsKeyCodeMap{
            HotKeys.unregister(id: UInt32(keyCode + activeFlag))
        }
        
        
        for ( _,keyCode) in Constents.moveKeyCode {
//            Log.write(errLevel: Log.INFO, catelog: "remove move key", value: String(UInt32(keyCode + shiftKey)))
            HotKeys.unregister(id: UInt32(keyCode + shiftKey))
        }
        
        HotKeys.unregister(id: UInt32(kVK_Return + activeFlag))
        HotKeys.unregister(id: UInt32(kVK_Return + shiftKey))
        HotKeys.unregister(id: UInt32(kVK_Escape + activeFlag))
        HotKeys.unregister(id: UInt32(kVK_ANSI_U + activeFlag))
        HotKeys.unregister(id: UInt32(kVK_ANSI_I + activeFlag))
        HotKeys.unregister(id: UInt32(kVK_ANSI_O + activeFlag))
        HotKeys.unregister(id: UInt32(kVK_ANSI_Period + activeFlag))
        HotKeys.unregister(id: UInt32(kVK_ANSI_U + activeFlag))
        HotKeys.unregister(id: UInt32(kVK_Space + activeFlag))
        HotKeys.unregister(id: UInt32(kVK_ANSI_C + activeFlag))


    }
    
    static func draw(){
        GradView.drawHorizLine(frac: 0)
        GradView.drawHorizLine(frac: 1/2.0)
        GradView.drawHorizLine(frac: 1.0)
        GradView.drawVertLine(frac:0)
        GradView.drawVertLine(frac:1/2.0)
        GradView.drawVertLine(frac:1.0)
    }
    
    static func resizeWindow(id:Int) {
        self.addLastPosition()
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
