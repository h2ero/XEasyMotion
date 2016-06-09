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
    @IBOutlet var statusMenu: NSMenu?
    var statusItem: NSStatusItem? = nil
    var aboutWindowController : AboutWindowController!
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        NSMenu.setMenuBarVisible(false)
        MainWindowController.maxWindow()
        AppDelegate.addHitKeyBind()
        AppDelegate.addClickBind()
        AppDelegate.addActiveKeyBind()
        AppDelegate.addMoveKeyBind()
        //        MainWindowController.hideWindow()
        showStatusBarMenu()
    }
    
    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
    
    static func addActiveKeyBind()  {
        HotKeys.register(UInt32(kVK_ANSI_I), modifiers: UInt32(cmdKey), block:{_ in
            MainWindowController.maxWindow()
            AppDelegate.addHitKeyBind();
            AppDelegate.addClickBind()
            AppDelegate.addMoveKeyBind();
            } , id: UInt32(kVK_ANSI_I))
    }
    
    static func addHitKeyBind()  {
        Log.write(Log.INFO, catelog: "register key code", value: "start")
        for (keyCode, _) in Constents.hintCharsKeyCodeMap{
            Log.write(Log.INFO, catelog: "register key code", value: keyCode)
            HotKeys.register(UInt32(keyCode), modifiers: UInt32(activeFlag), block:{
                (id:EventHotKeyID) in MainWindowController.resizeWindow(Int(id.id))
                //            let (x,y) = MainWindowController.getWinCenterPoint()
                //            Util.moveMouse(x, y: y)
                } , id: UInt32(keyCode))
        }
        Log.write(Log.INFO, catelog: "register key code", value: "end")
    }
    
    static func addMoveKeyBind()  {
        for (_, keyCode) in Constents.moveKeyCode {
            Log.write(Log.INFO, catelog: "register key code", value: keyCode)
            HotKeys.register(UInt32(keyCode), modifiers: UInt32(shiftKey), block:{
                (id:EventHotKeyID) in MainWindowController.moveWindow(Int(id.id))
                } , id: UInt32(keyCode + kVK_Shift))
        }
        
    }
    static func addClickBind()  {
        HotKeys.register(UInt32(kVK_Return), modifiers: UInt32(activeFlag), block:{_ in
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                // do some async stuff
                let (x,y) = MainWindowController.getWinCenterPoint()
                MainWindowController.hideWindow()
                AppDelegate.removeHintKeyBind();
                NSOperationQueue.mainQueue().addOperationWithBlock {
                    // do some main thread stuff stuff
                    Util.click(x, y: y)
                }
            }
            
            },id:UInt32(kVK_Return));
        
        HotKeys.register(UInt32(kVK_Return), modifiers: UInt32(shiftKey), block:{_ in
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                let (x,y) = MainWindowController.getWinCenterPoint()
                MainWindowController.hideWindow()
                AppDelegate.removeHintKeyBind();
                NSOperationQueue.mainQueue().addOperationWithBlock {
                    Util.rightClick(x, y: y)
                }
            }
            },id:UInt32(kVK_Return + kVK_Shift));
    }
    static func removeHintKeyBind(){
        for (keyCode, _) in Constents.hintCharsKeyCodeMap{
            HotKeys.unregister(UInt32(keyCode))
        }
        
        
        for ( _,keyCode) in Constents.moveKeyCode {
            HotKeys.unregister(UInt32(keyCode + kVK_Shift))
        }
        
        HotKeys.unregister(UInt32(kVK_Return))
        HotKeys.unregister(UInt32(kVK_Return + kVK_Shift))
    }
    
    func showStatusBarMenu(){
        
        self.statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-2 )
        self.statusItem!.menu = self.statusMenu
        if let button = self.statusItem!.button {
            button.image = NSImage(named: "statusBarIcon")
        }
        // show menu
        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "Abount \(Util.getAppName())", action: #selector(AppDelegate.showAbout(_:)), keyEquivalent: "P"))
        menu.addItem(NSMenuItem.separatorItem())
        menu.addItem(NSMenuItem(title: "Exit", action: #selector(AppDelegate.exitNow(_:)), keyEquivalent: "q"))
        
        self.statusItem!.menu = menu
    }
    
    @IBAction func showAbout(sender : AnyObject) {
        let storyboard : NSStoryboard = NSStoryboard(name: "Main", bundle: nil)
        self.aboutWindowController = storyboard.instantiateControllerWithIdentifier("AboutWindowController") as! AboutWindowController
        self.aboutWindowController.showWindow(self)
    }
    @IBAction func exitNow(sender: AnyObject) {
        NSApplication.sharedApplication().terminate(self)
    }
}

