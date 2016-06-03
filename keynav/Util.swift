//
//  Util.swift
//  keynav
//
//  Created by h2ero on 6/3/16.
//  Copyright © 2016 h2ero. All rights reserved.
//

import Foundation
import Cocoa

class Util {
    static func MoveMouse(x:CGFloat,y:CGFloat) ->NSPoint{
        let screenFrame = NSScreen.mainScreen()?.frame
        var point = NSPoint.init(x: x,y: screenFrame!.size.height - y)
        CGDisplayMoveCursorToPoint(CGMainDisplayID(), point)
        point = CGPointMake(point.x, point.y)
        CGDisplayMoveCursorToPoint(CGMainDisplayID(), point)
        return point
    }
    
    static func Click(x:CGFloat,y:CGFloat){
        let point = MoveMouse(x, y: y)
        PostMouseEvent(CGMouseButton.Left, type: CGEventType.LeftMouseDown, point: point);
        PostMouseEvent(CGMouseButton.Left, type: CGEventType.LeftMouseUp, point: point);
    }
    
    static func RightClick(x:CGFloat,y:CGFloat){
        let point = MoveMouse(x, y: y)
        PostMouseEvent(CGMouseButton.Right, type: CGEventType.RightMouseDown, point: point);
        PostMouseEvent(CGMouseButton.Right, type: CGEventType.RightMouseUp, point: point);
    }
    
    static func PostMouseEvent(button :CGMouseButton, type :CGEventType, point :NSPoint) {
        let theEvent = CGEventCreateMouseEvent(nil, type, point, button);
        CGEventSetType(theEvent, type);
        CGEventPost(CGEventTapLocation.CGHIDEventTap, theEvent);
    }
    
}