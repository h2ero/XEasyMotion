//
//  Util.swift
//  keynav
//
//  Created by h2ero on 6/3/16.
//  Copyright © 2016 h2ero. All rights reserved.
//

import Foundation
import Cocoa
import Carbon

class Util {
    static func moveMouse(x:CGFloat,y:CGFloat) ->NSPoint{
        let screenFrame = NSScreen.main?.frame
        let point = NSPoint.init(x: x,y: screenFrame!.size.height - y)
        CGDisplayMoveCursorToPoint(CGMainDisplayID(), point)
//        point = CGPointMake(point.x, point.y)
//        CGDisplayMoveCursorToPoint(CGMainDisplayID(), point)
        return point
    }
    
    static func click(x:CGFloat,y:CGFloat){
        let screenFrame = NSScreen.screens.first?.frame
        let point = NSMakePoint(x, (screenFrame?.size.height)!-y)
//        Log.write(errLevel: Log.INFO, catelog: "event", value: "== Click == POS: x:\(point.x) , y:\(point.y)")
        postMouseEvent(button: CGMouseButton.left, type: CGEventType.leftMouseDown, point: point);
        postMouseEvent(button: CGMouseButton.left, type: CGEventType.leftMouseUp, point: point);
    }
    
    static func rightClick(x: CGFloat, y: CGFloat){
        let screenFrame = NSScreen.main?.frame
        let point = NSMakePoint(x, screenFrame!.size.height - y)
//        Log.write(errLevel: Log.INFO, catelog: "event", value: "== Right Click == POS: x:\(point.x) , y:\(point.y)")
        postMouseEvent(button: CGMouseButton.right, type: CGEventType.rightMouseDown, point: point);
        postMouseEvent(button: CGMouseButton.right, type: CGEventType.rightMouseUp, point: point);
    }
    
    static func postMouseEvent(button :CGMouseButton, type :CGEventType, point :NSPoint) {
        let theEvent = CGEvent(mouseEventSource: nil, mouseType: type, mouseCursorPosition: point, mouseButton: button);
//        CGEventSetType(theEvent, type);
        theEvent?.post(tap: CGEventTapLocation.cghidEventTap)
    }
    
    static func getPostion(hintChar:String, startX :CGFloat, startY:CGFloat, width:CGFloat, height:CGFloat) -> (CGFloat, CGFloat) {
        let xStep = width / 3
        let yStep = height / 3
        
        var x : Int = 0;
        var y : Int = 0;
        breakLabel : for (index, row)  in Constents.hintChars.enumerated(){
            for(subIndex,checkHintChar) in row.enumerated(){
                if hintChar == checkHintChar {
                    x = subIndex;
                    y = index;
                    break breakLabel;
                }
            }
            
        }
        
        return (CGFloat(x) * xStep + startX , (-CGFloat(y) * yStep) + height - yStep + startY)
    }
    static func getAppVersion() -> String {
        return Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    }
    
    static func getAppName() -> String {
        return Bundle.main.infoDictionary!["CFBundleName"] as! String
    }
    
    static func getWindowFirst() -> NSWindow {
        return NSApplication.shared.windows.first!
    }
    
    static func getChar( ch: UInt32 ) -> String {
        return String(describing: UnicodeScalar(ch))
    }
    
    static func getFileContent(path : String) -> String {
        let checkValidation = FileManager.default
        if checkValidation.fileExists(atPath: path) == false {
            return ""
        }
        return (try? NSString(contentsOfFile: path, encoding: String.Encoding.utf8.rawValue)) as! String
    }
    
    static func getFileContentFromBundle(path:String) -> String{
        let checkValidation = FileManager.default
        let filePath = Bundle.main.path(forResource: "", ofType:"*")! as String;
        if checkValidation.fileExists(atPath: filePath) == false {
            return ""
            
        }
        return (try? NSString(contentsOfFile: filePath, encoding: String.Encoding.utf8.rawValue)) as! String
    }
    
    static func openUrl(url:String){
        if let url = URL(string: url), NSWorkspace.shared.open(url) {
        }
    }
    static func getVersion() -> String {
        return Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    }
 
}
