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
        Keybind.addActiveKeyBind()
        Keybind.addHitKeyBind()
        Keybind.addClickBind()
        Keybind.addMoveKeyBind()
        Keybind.addCancelKeyBind()
        //        MainWindowController.hideWindow()
        showStatusBarMenu()
    }
    
    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
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

