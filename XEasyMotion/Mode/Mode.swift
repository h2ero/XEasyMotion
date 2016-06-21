
//  Mode.swift
//  XEasyMotion
//
//  Created by h2ero on 6/19/16.
//  Copyright © 2016 h2ero. All rights reserved.
//

import Foundation
import Carbon

class Mode {
    static func addActiveKeyBind()  {
        HotKeys.register(UInt32(kVK_ANSI_I), modifiers: UInt32(cmdKey), block:{_ in
            MainWindowController.maxWindow()
//            Keybind.addHitKeyBind()
//            Keybind.addClickBind()
//            Keybind.addMoveKeyBind()
//            Keybind.addCancelKeyBind()
        })
    }
    
    static func addCancelKeyBind() {
        HotKeys.register(UInt32(kVK_Escape), modifiers: UInt32(activeFlag), block:{
            (id:EventHotKeyID) in
            MainWindowController.hideWindow()
//            Keybind.removeKeyBind();
        })
    }
}