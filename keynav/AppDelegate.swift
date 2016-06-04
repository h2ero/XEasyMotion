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
    var m_aboutWindowController : AboutWindowController!
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
//        let storyboard = NSStoryboard(name: "Main", bundle: nil)
//        AppDelegate.mainWindowController = storyboard.instantiateControllerWithIdentifier("MainWindowController") as? MainWindowController
        NSMenu.setMenuBarVisible(false)
        MainWindowController.maxWindow()
        AppDelegate.addHitKeyBind()
        AppDelegate.addClickBind()
        AppDelegate.addActiveKeyBind()
        showStatusBarMenu()
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
            var (x,y) = MainWindowController.getWinCenterPoint()
            Util.moveMouse(x, y: y)
                } , id: UInt32(keyCode))
        }
    }
    
    static func addClickBind()  {
        Test.register(UInt32(kVK_Return), modifiers: UInt32(activeFlag), block:{_ in
            var (x,y) = MainWindowController.getWinCenterPoint()
            MainWindowController.hideWindow()
            Util.click(x, y: y)
            AppDelegate.removeHintKeyBind();
            },id:UInt32(kVK_Return));
        
        Test.register(UInt32(kVK_Return), modifiers: UInt32(shiftKey), block:{_ in
            var (x,y) = MainWindowController.getWinCenterPoint()
            MainWindowController.hideWindow()
            Util.rightClick(x, y: y)
            AppDelegate.removeHintKeyBind();
            },id:UInt32(kVK_Return + kVK_Shift));
    }
    static func removeHintKeyBind(){
        for (keyCode, _) in Constents.hintCharsKeyCodeMap{
            Test.unregister(UInt32(keyCode))
        }
//        Test.unregister(UInt32(kVK_Return))

    }
  
    func showStatusBarMenu(){
        
        self.statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-2 )
        self.statusItem!.menu = self.statusMenu
        if let button = self.statusItem!.button {
            button.image = NSImage(named: "statusBarIcon")
        }
        // show menu
        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "Abount XEasyMontion", action: #selector(AppDelegate.showAbout(_:)), keyEquivalent: "P"))
        menu.addItem(NSMenuItem.separatorItem())
        menu.addItem(NSMenuItem(title: "Exit", action: #selector(AppDelegate.exitNow(_:)), keyEquivalent: "q"))
        
        self.statusItem!.menu = menu
    }
    
    @IBAction func showAbout(sender : AnyObject) {
        let storyboard : NSStoryboard = NSStoryboard(name: "Main", bundle: nil)
        self.m_aboutWindowController = storyboard.instantiateControllerWithIdentifier("AboutWindowController") as! AboutWindowController
        self.m_aboutWindowController.showWindow(self)
    }
    @IBAction func exitNow(sender: AnyObject) {
        NSApplication.sharedApplication().terminate(self)
    }
}

