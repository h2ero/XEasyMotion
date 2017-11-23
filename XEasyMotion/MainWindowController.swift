//
//  MainWindowController.swift
//  keynav
//
//  Created by h2ero on 5/26/16.
//  Copyright © 2016 h2ero. All rights reserved.
//

import Foundation

import Cocoa
import Carbon

class MainWindowController: NSWindowController {
    @IBOutlet var statusMenu: NSMenu?
    
    var statusItem: NSStatusItem? = nil
   
    override func windowDidLoad() {
        
        NSMenu.setMenuBarVisible(false)
        Mode.maxWindow()
        // todo reflection
        
        
        if Config.getEnableMode()  == Constents.simpleMode {
            SimpleMode.load()
        }else{
            NineBlockMode.load()
        }
        
        
        showStatusBarMenu()
        
        super.windowDidLoad()
    }
    
    
  
    func showStatusBarMenu(){
        
        self.statusItem = NSStatusBar.system.statusItem(withLength: -2 )
        if let button = self.statusItem!.button {
            button.image = NSImage(named: NSImage.Name(rawValue: "statusBarIcon"))
        }
        // show menu
        let menu = NSMenu()
        menu.autoenablesItems = false
      
        
        menu.addItem(NSMenuItem(title: "About \(Util.getAppName())", action: #selector(AppDelegate.showAbout), keyEquivalent: "A"))
        menu.addItem(NSMenuItem(title: "Version \(Util.getVersion())", action: nil, keyEquivalent: "V"))

        menu.addItem(NSMenuItem.separator())

        menu.addItem(NSMenuItem(title: "Exit", action: #selector(AppDelegate.exitNow), keyEquivalent: "Q"))
        
        self.statusItem!.menu = menu
    }
    
}
