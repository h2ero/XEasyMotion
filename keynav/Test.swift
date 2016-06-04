//
//  Test.swift
//  awesome4mac
//
//  Created by shuoshichen on 15/12/26.
//  Copyright © 2015年 com.imhuihui. All rights reserved.
//

import Foundation
import Carbon

class Test {
    private let hotKey: UInt32
    private let block: () -> ()
    private var registered = true
    
    typealias action = () -> Void
    static var shortcuts = [UInt32:action]()
    
    private init(hotKeyID: UInt32, block: () -> ()) {
        self.hotKey = hotKeyID
        self.block = block
        Test.shortcuts[hotKey] = block
    }
    
    static func registerHandler() {
        var eventHandler: EventHandlerRef = nil
        var eventType = EventTypeSpec(eventClass: OSType(kEventClassKeyboard), eventKind: UInt32(kEventHotKeyPressed))
        
        InstallEventHandler(GetApplicationEventTarget(), {(handlerRef: EventHandlerCallRef, eventRef: EventRef, ptr: UnsafeMutablePointer<Void>) -> OSStatus in
            var hotKeyID: EventHotKeyID = EventHotKeyID()
            GetEventParameter(eventRef, OSType(kEventParamDirectObject), EventParamType(typeEventHotKeyID), nil, sizeof(EventHotKeyID), nil, &hotKeyID)
            //call defined action based on hotKeyID
            Test.shortcuts[hotKeyID.id]!()
            return noErr
            }, 1, &eventType, nil, &eventHandler) == noErr
    }
    
    private static var token: dispatch_once_t = 0
    
    class func register(keyCode: UInt32, modifiers: UInt32, block: () -> (), id: UInt32) -> Test? {
        dispatch_once(&token) {
            Test.registerHandler()
        }
        var hotKey: EventHotKeyRef = nil
        let hotKeyID = EventHotKeyID(signature:OSType(10000), id: id)
        RegisterEventHotKey(keyCode, modifiers, hotKeyID, GetApplicationEventTarget(), OptionBits(0), &hotKey)
        return Test(hotKeyID: id, block: block)
    }
    
}