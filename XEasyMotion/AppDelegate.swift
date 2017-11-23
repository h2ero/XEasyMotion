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
    var settingWindowController : SettingWindowController!
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        NSMenu.setMenuBarVisible(false)
        Mode.maxWindow()
        // todo reflection
        if Config.getEnableMode()  == Constents.simpleMode {
            SimpleMode.load()
        }else{
            NineBlockMode.load()
        }
        // MainWindowController.hideWindow()
        showStatusBarMenu()
    }
    
    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
    
    func showStatusBarMenu(){
        
        self.statusItem = NSStatusBar.system.statusItem(withLength: -2 )
        self.statusItem!.menu = self.statusMenu
        if let button = self.statusItem!.button {
            button.image = NSImage(named: NSImage.Name(rawValue: "statusBarIcon"))
        }
        // show menu
        let menu = NSMenu()
        
//        menu.addItem(NSMenuItem(title: "About \(Util.getAppName())", action: #selector(AppDelegate.showAbout(_:)), keyEquivalent: "A"))
        
//        menu.addItem(NSMenuItem(title: "Setting", action: #selector(AppDelegate.showSetting(_:)), keyEquivalent: "S"))
        
        menu.addItem(NSMenuItem.separator())
        
//        menu.addItem(NSMenuItem(title: "Exit", action: #selector(AppDelegate.exitNow(_:)), keyEquivalent: "Q"))
        
        self.statusItem!.menu = menu
    }
    
    @IBAction func showAbout(sender : AnyObject) {
        let storyboard : NSStoryboard = NSStoryboard(name: NSStoryboard.Name(rawValue: "Main"), bundle: nil)
        self.aboutWindowController = storyboard.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "AboutWindowController")) as! AboutWindowController
        self.aboutWindowController.showWindow(self)
    }
    @IBAction func exitNow(sender: AnyObject) {
//        NSApplication.sharedshared().terminate(self)
    }
    
    @IBAction func showSetting(sender : AnyObject) {
        let storyboard : NSStoryboard = NSStoryboard(name: NSStoryboard.Name(rawValue: "Main"), bundle: nil)
        self.settingWindowController = storyboard.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "SettingWindowController")) as! SettingWindowController
        self.settingWindowController.showWindow(self)
    }
}

