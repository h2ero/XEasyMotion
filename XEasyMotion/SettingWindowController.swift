//
//  SettingWindowController.swift
//  XEasyMotion
//
//  Created by h2ero on 6/18/16.
//  Copyright © 2016 h2ero. All rights reserved.
//

import Foundation
//
//  AboutWindowController.swift
//  keynav
//
//  Created by h2ero on 6/4/16.
//  Copyright © 2016 h2ero. All rights reserved.
//

import Cocoa
import Foundation
class SettingWindowController: NSWindowController {
    
    override func windowDidLoad() {
        super.windowDidLoad()
        window!.title = "Setting"
        window!.center()
        window!.level = NSWindow.Level(rawValue: Int(CGWindowLevelForKey(CGWindowLevelKey.statusWindow)) +
            Int(CGWindowLevelForKey(CGWindowLevelKey.dockWindow)) +
            Int(CGWindowLevelForKey(CGWindowLevelKey.popUpMenuWindow)))
        Int(CGWindowLevelForKey(CGWindowLevelKey.mainMenuWindow))
        
    }
    
}
