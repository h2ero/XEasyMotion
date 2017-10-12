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
    static let mainBundle = Bundle.main
    static let bundleID = mainBundle.bundleIdentifier! as String
    static let bundleName = mainBundle.infoDictionary!["CFBundleName"]
    static let bundleVersion = mainBundle.infoDictionary!["CFBundleShortVersionString"]
    //    static let tempDirectory = NSTemporaryDirectory()
    static let tempDirectory = "/tmp/"
    static var logName = Log.tempDirectory + ("\(Log.bundleID).log")
    
    
    static func write(errLevel:String, catelog:String, value:AnyObject) {
        let value = "[\(errLevel)][\(catelog)] " + String(describing: value)
   
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        NSLog(logName)
        if let outputStream = OutputStream(toFileAtPath: logName, append: true) {
            outputStream.open()
            let text = "\(formatter.string(from: NSDate() as Date)) \(Log.bundleID)-\(NSDate().timeIntervalSince1970) \(value)\n"
//            let data = text.data(using: String.Encoding.utf8, allowLossyConversion: false)!
//            outputStream.write(UnsafePointer<UInt8>(data.bytes), maxLength: data.length)
            let data: NSData = text.data(using: String.Encoding.utf8)! as NSData
            let p: UnsafePointer = data.bytes.assumingMemoryBound(to: UInt8.self)
            outputStream.write(p, maxLength: data.length)
            outputStream.close()
        }
        NSLog(value)
    }
}
