//
//  Log.swift
//  XEasyMotion
//
//  Created by h2ero on 6/6/16.
//  Copyright © 2016 h2ero. All rights reserved.
//

import Foundation
class Log {
    static let (ERROR,INFO) = ("Error",  "Info")
    static let mainBundle = NSBundle.mainBundle()
    static let bundleID = mainBundle.bundleIdentifier! as String
    static let bundleName = mainBundle.infoDictionary!["CFBundleName"]
    static let bundleVersion = mainBundle.infoDictionary!["CFBundleShortVersionString"]
    //    static let tempDirectory = NSTemporaryDirectory()
    static let tempDirectory = "/tmp/"
    static var logName = Log.tempDirectory.stringByAppendingString("\(Log.bundleID).log")
    
    
    static func write(errLevel:String, catelog:String, value:AnyObject) {
        let value = "[\(errLevel)][\(catelog)] " + String(value)
        if Constents.debug == false {
            NSLog(value)
            return
        }
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        NSLog(logName)
        if let outputStream = NSOutputStream(toFileAtPath: logName, append: true) {
            outputStream.open()
            let text = "\(formatter.stringFromDate(NSDate())) \(Log.bundleID)-\(NSDate().timeIntervalSince1970) \(value)\n"
            let data = text.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!
            outputStream.write(UnsafePointer(data.bytes), maxLength: data.length)
            outputStream.close()
        }
        NSLog(value)
    }
}