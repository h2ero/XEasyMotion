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
    required init?(coder: NSCoder) {
        super.init(coder: coder)
//        self.backgroundColor = NSColor.clearColor()
//        self.backgroundColor = NSColor.blueColor()
//        self.opaque = false
//        self.titleVisibility = .Hidden
    }
    
    override init(contentRect: NSRect, styleMask aStyle: Int, backing bufferingType: NSBackingStoreType, `defer` flag: Bool) {
        super.init(contentRect: contentRect, styleMask: NSBorderlessWindowMask, backing: bufferingType, defer: flag)
    
        // z-index
        self.level = Int(CGWindowLevelForKey(CGWindowLevelKey.StatusWindowLevelKey));

        
        self.backgroundColor = NSColor.clearColor()
        self.opaque = false
        self.titleVisibility = .Hidden
        
        self.backgroundColor = NSColor.whiteColor()
    }
    
}
