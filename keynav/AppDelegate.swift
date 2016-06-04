//
//  AppDelegate.swift
//  keynav
//
//  Created by h2ero on 5/26/16.
//  Copyright © 2016 h2ero. All rights reserved.
//

import Cocoa

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
        Test.register(UInt32(kVK_ANSI_E), modifiers: UInt32(activeFlag), block: {
            AppDelegate.mainWindowController!.resizeWindow(kVK_ANSI_E)
        } , id: UInt32(kVK_ANSI_E))
    }
    
    static func testA(s:String)   {
        NSLog(s)
    }
}

