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
    
    //    static var mainWindowController: MainWindowController?
    var statusItem: NSStatusItem? = nil
    var aboutWindowController : AboutWindowController!
    var settingWindowController : SettingWindowController!
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // MainWindowController.hideWindow()
    }
    
    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
    @objc func showAbout(menu:NSMenu){
        Util.openUrl(url: "https://github.com/h2ero/XEasyMotion")
//        let storyboard : NSStoryboard = NSStoryboard(name: NSStoryboard.Name(rawValue: "Main"), bundle: nil)
//        self.aboutWindowController = storyboard.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "AboutWindowController")) as! AboutWindowController
//        self.aboutWindowController.showWindow(self)
    }
    @objc func showSetting(menu:NSMenu) {
        let storyboard : NSStoryboard = NSStoryboard(name: NSStoryboard.Name(rawValue: "Main"), bundle: nil)
        self.settingWindowController = storyboard.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "SettingWindowController")) as! SettingWindowController
        self.settingWindowController.showWindow(self)
    }

    @objc func exitNow(menu:NSMenu){
        NSApplication.shared.terminate(self)
    }
  
}

