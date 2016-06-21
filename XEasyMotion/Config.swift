//
//  Config.swift
//  XEasyMotion
//
//  Created by h2ero on 6/19/16.
//  Copyright © 2016 h2ero. All rights reserved.
//

import Foundation
import Yaml
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
    
    static func loadConfig() -> Yaml {
        // todo only load once
        let fileConent = Util.getFileContent(Config.getConfigPath())
        return Yaml.load(fileConent).value!
    }
    
    static func getEnableMode() -> String {
        let configs = Config.loadConfig()
        Log.write(Log.INFO, catelog: "conf", value: configs["enableMode"].string!)
        return configs["enableMode"].string!
    }
    
}
