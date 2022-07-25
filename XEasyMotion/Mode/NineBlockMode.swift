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
        self.addRestoreKeyBind()
        self.addHitKeyBind()
        self.addClickBinds()
        self.addMoveKeyBind()
        self.addCancelKeyBind()
    }
    
    override static func addHitKeyBind()  {
//        Log.write(Log.INFO, catelog: "register key code", value: "start")
        for (keyCode, _) in Constents.hintCharsKeyCodeMap{
//            Log.write(Log.INFO, catelog: "register key code", value: keyCode)
            HotKeys.register(keycode: UInt32(keyCode), modifiers: UInt32(activeFlag), block:{
                (id:EventHotKeyID) in self.resizeWindow(id: Int(id.id))
                //                let (x,y) = self.getWinCenterPoint()
                //                Util.moveMouse(x, y: y)
            })
        }
//        Log.write(errLevel: Log.INFO, catelog: "register key code", value: "end")
    }
    
    override static func addMoveKeyBind()  {
        for (_, keyCode) in Constents.moveKeyCode {
//            Log.write(errLevel: Log.INFO, catelog: "register key code", value: keyCode)
            HotKeys.register(keycode: UInt32(keyCode), modifiers: UInt32(shiftKey), block:{
                (id:EventHotKeyID) in
//                Log.write(Log.INFO, catelog: "move", value: String(id.id))
                self.moveWindow(dirction: Int(id.id))
            })
        }
        
    }
    
    override static func addClickBinds()  {
        HotKeys.register(keycode: UInt32(kVK_Return), modifiers: UInt32(activeFlag), block:{_ in
            DispatchQueue.global().async {
                // do some async stuff
                let (x,y) = self.getWinCenterPoint()
                self.hideWindow()
                self.removeKeyBind();
                DispatchQueue.main.async{
                    // do some main thread stuff stuff
                    Util.click(x: x, y: y)
                }
            }
            
        });
        
        HotKeys.register(keycode: UInt32(kVK_Return), modifiers: UInt32(shiftKey), block:{_ in
            DispatchQueue.global().async {
                let (x,y) = self.getWinCenterPoint()
                self.hideWindow()
                self.removeKeyBind();
                DispatchQueue.main.async{
                    Util.rightClick(x: x, y: y)
                }
            }
        });
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
    }
    static func draw(){
        
        GradView.drawHorizLine(frac: 0)
        GradView.drawHorizLine(frac: 1)
        GradView.drawHorizLine(frac: 1/3.0)
        GradView.drawHorizLine(frac: 2/3.0)
        
        GradView.drawVertLine(frac: 1/3.0)
        GradView.drawVertLine(frac: 2/3.0)
        GradView.drawVertLine(frac: 0)
        GradView.drawVertLine(frac: 1)
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
        
        for (y, row) in Constents.hintChars.enumerated(){
            for(x, hintChar) in row.enumerated(){
                GradView.drawChar(text: hintChar as NSString, x:  xAxis[x] - (GradView.getHintCharFontSize()/2), y: yAxis[y] - (GradView.getHintCharFontSize() / 2))
            }
        }
    }
    
    static func resizeWindow(id:Int) {
        self.addLastPosition()
        let windowFirst = Util.getWindowFirst()
        var windowFrame = windowFirst.frame
        
        let hitChar = Constents.hintCharsKeyCodeMap[id - activeFlag]
        Log.write(errLevel: Log.INFO, catelog: "nine block resize", value: hitChar! as AnyObject)
        let oldWidth = windowFrame.size.width
        let oldHeight = windowFrame.size.height
        let toAdd = CGFloat(0.33333)
        let newWidth = oldWidth  * toAdd
        let newHeight = oldHeight * toAdd
        // get x , y
        windowFrame.size = NSMakeSize(newWidth, newHeight)
        (windowFrame.origin.x, windowFrame.origin.y) =  Util.getPostion(hintChar: hitChar!, startX: (windowFrame.origin.x), startY: (windowFrame.origin.y), width: oldWidth, height: oldHeight)
        
        
        windowFirst.setFrame(windowFrame,display: true,animate: Constents.animation)
    }
    
}
