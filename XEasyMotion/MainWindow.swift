//
//  MainWindow.swift
//  keynav
//
//  Created by h2ero on 5/26/16.
//  Copyright © 2016 h2ero. All rights reserved.
//

import Foundation
import Cocoa

class MainWindow: NSWindow {
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//    }
    override init(contentRect: NSRect, styleMask style: NSWindow.StyleMask, backing backingStoreType: NSWindow.BackingStoreType, defer flag: Bool) {

        super.init(contentRect: contentRect, styleMask: NSWindow.StyleMask(rawValue: NSWindow.StyleMask.RawValue(NSWindow.StyleMask.borderless.rawValue|NSWindow.StyleMask.fullSizeContentView.rawValue)), backing: NSWindow.BackingStoreType.buffered, defer: false)
        
        // z-index
        self.level = NSWindow.Level(rawValue: Int(CGWindowLevelForKey(CGWindowLevelKey.statusWindow)) +
            Int(CGWindowLevelForKey(CGWindowLevelKey.dockWindow)) +
            Int(CGWindowLevelForKey(CGWindowLevelKey.popUpMenuWindow)))
        Int(CGWindowLevelForKey(CGWindowLevelKey.mainMenuWindow))
        
        self.animationBehavior = .none
        
        self.alphaValue = 1.0
        
        self.isOpaque = false
        //        self.hidesOnDeactivate = true
        self.backgroundColor = NSColor.clear
        self.titleVisibility = .hidden
    }
    
  
    override var canBecomeKey: Bool {
        return false
    }
    override var canBecomeMain: Bool{
        return false;
    }
}
