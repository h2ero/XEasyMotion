//
//  Config.swift
//  XEasyMotion
//
//  Created by h2ero on 6/19/16.
//  Copyright © 2016 h2ero. All rights reserved.
//

import Foundation
import Yaml
class Config {
    
    static let dotfile = ".xeasymotionrc"
    static var configs :[Yaml] = []
    static func getConfigPath() -> String{
        return NSHomeDirectory() + "/" + Config.dotfile
    }
    
    
    init() {
        Config.loadConfig()
    }
    
    static func loadConfig() {
        if Config.configs == [] {
            let fileConent = Util.getFileContent(Config.getConfigPath())
            Config.configs = Yaml.loadMultiple(fileConent).value!
            Log.write(Log.INFO, catelog: "config", value: "load config")
        }
    }
    
    //
    static func getHitChars() {
    }
    
}
