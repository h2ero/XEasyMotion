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
        let screenFrame = NSScreen.mainScreen()?.frame
        let point = NSPoint.init(x: x,y: screenFrame!.size.height - y)
        CGDisplayMoveCursorToPoint(CGMainDisplayID(), point)
//        point = CGPointMake(point.x, point.y)
//        CGDisplayMoveCursorToPoint(CGMainDisplayID(), point)
        return point
    }
    
    static func click(x:CGFloat,y:CGFloat){
        let screenFrame = NSScreen.screens()?.first?.frame
        let point = NSMakePoint(x, (screenFrame?.size.height)!-y)
        Log.write(Log.INFO, catelog: "event", value: "== Click == POS: x:\(point.x) , y:\(point.y)")
        postMouseEvent(CGMouseButton.Left, type: CGEventType.LeftMouseDown, point: point);
        postMouseEvent(CGMouseButton.Left, type: CGEventType.LeftMouseUp, point: point);
    }
    
    static func rightClick(x: CGFloat, y: CGFloat){
        let screenFrame = NSScreen.mainScreen()?.frame
        let point = NSMakePoint(x, screenFrame!.size.height - y)
        Log.write(Log.INFO, catelog: "event", value: "== Right Click == POS: x:\(point.x) , y:\(point.y)")
        postMouseEvent(CGMouseButton.Right, type: CGEventType.RightMouseDown, point: point);
        postMouseEvent(CGMouseButton.Right, type: CGEventType.RightMouseUp, point: point);
    }
    
    static func postMouseEvent(button :CGMouseButton, type :CGEventType, point :NSPoint) {
        let theEvent = CGEventCreateMouseEvent(nil, type, point, button);
        CGEventSetType(theEvent, type);
        CGEventPost(CGEventTapLocation.CGHIDEventTap, theEvent);
    }
    
    static func getPostion(hintChar:String, startX :CGFloat, startY:CGFloat, width:CGFloat, height:CGFloat) -> (CGFloat, CGFloat) {
        let xStep = width / 3
        let yStep = height / 3
        
        var x : Int = 0;
        var y : Int = 0;
        breakLabel : for (index, row)  in Constents.hintChars.enumerate(){
            for(subIndex,checkHintChar) in row.enumerate(){
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
        return NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"] as! String
    }
    
    static func getAppName() -> String {
        return NSBundle.mainBundle().infoDictionary!["CFBundleName"] as! String
    }
    
    static func getWindowFirst() -> NSWindow {
        return NSApplication.sharedApplication().windows.first!
    }
    
    static func getChar( ch: UInt32 ) -> String {
        return String(UnicodeScalar(ch))
    }
    
 
}