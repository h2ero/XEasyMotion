//
//  SimpleMode.swift
//  XEasyMotion
//
//  Created by h2ero on 6/19/16.
//  Copyright © 2016 h2ero. All rights reserved.
//

import Foundation
import Carbon

class SimpleMode : Mode{
    
    static func load(){
        SimpleMode.addActiveKeyBind()
        SimpleMode.addHitKeyBind()
        SimpleMode.addClickBind()
        SimpleMode.addMoveKeyBind()
        SimpleMode.addCancelKeyBind()
    }
    
    static func finish(){
        
    }
    
//    static func addActiveKeyBind()  {
//        HotKeys.register(UInt32(kVK_ANSI_I), modifiers: UInt32(cmdKey), block:{_ in
//            MainWindowController.maxWindow()
//            SimpleMode.addHitKeyBind()
//            SimpleMode.addClickBind()
//            SimpleMode.addMoveKeyBind()
//            SimpleMode.addCancelKeyBind()
//        })
//    }
    
    static func addHitKeyBind()  {
        Log.write(Log.INFO, catelog: "register key code", value: "start")
        for (keyCode, _) in Constents.hintCharsKeyCodeMap{
            Log.write(Log.INFO, catelog: "register key code", value: keyCode)
            HotKeys.register(UInt32(keyCode), modifiers: UInt32(activeFlag), block:{
                (id:EventHotKeyID) in MainWindowController.resizeWindow(Int(id.id))
                //                let (x,y) = MainWindowController.getWinCenterPoint()
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
                MainWindowController.moveWindow(Int(id.id))
            })
        }
        
    }
    
    static func addClickBind()  {
        HotKeys.register(UInt32(kVK_Return), modifiers: UInt32(activeFlag), block:{_ in
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                // do some async stuff
                let (x,y) = MainWindowController.getWinCenterPoint()
                MainWindowController.hideWindow()
                SimpleMode.removeKeyBind();
                NSOperationQueue.mainQueue().addOperationWithBlock {
                    // do some main thread stuff stuff
                    Util.click(x, y: y)
                }
            }
            
        });
        
        HotKeys.register(UInt32(kVK_Return), modifiers: UInt32(shiftKey), block:{_ in
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                let (x,y) = MainWindowController.getWinCenterPoint()
                MainWindowController.hideWindow()
                SimpleMode.removeKeyBind();
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
    
}