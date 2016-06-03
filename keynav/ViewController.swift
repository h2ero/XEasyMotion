//
//  ViewController.swift
//  keynav
//
//  Created by h2ero on 5/26/16.
//  Copyright © 2016 h2ero. All rights reserved.
//

import Cocoa
import AppKit

class ViewController: NSViewController  {

    @IBOutlet var gradView: NSView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        let presOptions: NSApplicationPresentationOptions = ([.FullScreen,.AutoHideMenuBar])
//        /*These are all of the options for NSApplicationPresentationOptions
//         .Default
//         .AutoHideDock              |   /
//         .AutoHideMenuBar           |   /
//         .DisableForceQuit          |   /
//         .DisableMenuBarTransparency|   /
//         .FullScreen                |   /
//         .HideDock                  |   /
//         .HideMenuBar               |   /
//         .DisableAppleMenu          |   /
//         .DisableProcessSwitching   |   /
//         .DisableSessionTermination |   /
//         .DisableHideApplication    |   /
//         .AutoHideToolbar
//         .HideMenuBar               |   /
//         .DisableAppleMenu          |   /
//         .DisableProcessSwitching   |   /
//         .DisableSessionTermination |   /
//         .DisableHideApplication    |   /
//         .AutoHideToolbar */
//
//        let optionsDictionary = [NSFullScreenModeApplicationPresentationOptions :
//            NSNumber(unsignedLong: presOptions.rawValue)]
//        
//        self.view.enterFullScreenMode(NSScreen.mainScreen()!, withOptions:optionsDictionary)
//        self.view.wantsLayer = true
    }
    
    override func viewWillAppear() {
        gradView.layer?.backgroundColor = NSColor.clearColor().CGColor
    }

    override var representedObject: AnyObject? {
        didSet {
        }
    }
    

}