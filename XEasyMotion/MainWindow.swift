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
    override init(contentRect: NSRect, styleMask style: NSWindowStyleMask, backing backingStoreType: NSBackingStoreType, defer flag: Bool) {
        
        super.init(contentRect: contentRect, styleMask: NSWindowStyleMask(rawValue: NSWindow.StyleMask.RawValue(NSBorderlessWindowMask.rawValue|NSFullSizeContentViewWindowMask.rawValue)), backing: NSBackingStoreType.buffered, defer: false)
        
        // z-index
        self.level = Int(CGWindowLevelForKey(CGWindowLevelKey.statusWindow)) +
            Int(CGWindowLevelForKey(CGWindowLevelKey.dockWindow)) +
            Int(CGWindowLevelForKey(CGWindowLevelKey.popUpMenuWindow))
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
