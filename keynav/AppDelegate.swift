//
//  AppDelegate.swift
//  keynav
//
//  Created by h2ero on 5/26/16.
//  Copyright © 2016 h2ero. All rights reserved.
//

import Cocoa
import Carbon

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

//    static var mainWindowController: MainWindowController?
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
//        let storyboard = NSStoryboard(name: "Main", bundle: nil)
//        AppDelegate.mainWindowController = storyboard.instantiateControllerWithIdentifier("MainWindowController") as? MainWindowController
        MainWindowController.maxWindow()
        AppDelegate.addHitKeyBind()
        AppDelegate.addClickBind()
        AppDelegate.addActiveKeyBind()
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
    
    static func addActiveKeyBind()  {
        Test.register(UInt32(kVK_ANSI_I), modifiers: UInt32(cmdKey), block:{_ in
                MainWindowController.maxWindow()
                AppDelegate.addHitKeyBind();
                AppDelegate.addClickBind()
            } , id: UInt32(kVK_ANSI_I))
    }
    
    static func addHitKeyBind()  {
        for (keyCode, _) in Constents.hintCharsKeyCodeMap{
            NSLog(String(keyCode))
            Test.register(UInt32(keyCode), modifiers: UInt32(activeFlag), block:{
                (id:EventHotKeyID) in MainWindowController.resizeWindow(Int(id.id))
                } , id: UInt32(keyCode))
        }
    }
    
    static func addClickBind()  {
        Test.register(UInt32(kVK_Return), modifiers: UInt32(activeFlag), block:{_ in
            var (x,y) = MainWindowController.getWinCenterPoint()
            MainWindowController.hideWindow()
            Util.rightClick(x, y: y)
            AppDelegate.removeHintKeyBind();
            },id:UInt32(kVK_ANSI_KeypadEnter));
    }
    static func removeHintKeyBind(){
        for (keyCode, _) in Constents.hintCharsKeyCodeMap{
            Test.unregister(UInt32(keyCode))
        }
        Test.unregister(UInt32(kVK_Return))

    }
  
}

