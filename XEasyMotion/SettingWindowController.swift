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
        window!.level = Int(CGWindowLevelForKey(CGWindowLevelKey.StatusWindowLevelKey)) +
            Int(CGWindowLevelForKey(CGWindowLevelKey.DockWindowLevelKey)) +
            Int(CGWindowLevelForKey(CGWindowLevelKey.PopUpMenuWindowLevelKey))
            Int(CGWindowLevelForKey(CGWindowLevelKey.MainMenuWindowLevelKey))
        
    }
    
}