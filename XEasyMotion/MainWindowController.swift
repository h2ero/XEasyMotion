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
    
    override func windowDidLoad() {
        
        NSMenu.setMenuBarVisible(false)
        Mode.maxWindow()
        // todo reflection
       
        
        if Config.getEnableMode()  == Constents.simpleMode {
            SimpleMode.load()
        }else{
            NineBlockMode.load()
        }
        super.windowDidLoad()
    }
    
}
