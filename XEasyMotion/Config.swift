//
//  Config.swift
//  XEasyMotion
//
//  Created by h2ero on 6/19/16.
//  Copyright © 2016 h2ero. All rights reserved.
//

import Foundation
import Cocoa
import Carbon

class Config {
    
    static let dotfile = ".xeasymotionrc"
    static func getConfigPath() -> String{
        return NSHomeDirectory() + "/" + Config.dotfile
    }
    
    
    init() {
//        Config.loadConfig()
    }
    

    
    static func getEnableMode() -> String {
        return Constents.simpleMode
//        let configs = Config.loadConfig()
//        Log.write(Log.INFO, catelog: "conf", value: configs["enableMode"].string!)
//        let mode = configs["enableMode"].string!
//        if mode.isEmpty {
//            return Constents.simpleMode
//        }
//        return mode
    }
    
}
