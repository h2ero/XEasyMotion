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

    static var mainWindowController: MainWindowController?
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        AppDelegate.mainWindowController = MainWindowController()
        AppDelegate.mainWindowController!.showWindow(self)
        addKeyBind()
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }

    func addKeyBind()  {
        for (keyCode, _) in Constents.hintCharsKeyCodeMap{
            NSLog(String(keyCode))
            Test.register(UInt32(keyCode), modifiers: UInt32(activeFlag), block:{
                (id:EventHotKeyID) in AppDelegate.mainWindowController!.resizeWindow(Int(id.id))
                } , id: UInt32(keyCode))
        }
    }
  
}

