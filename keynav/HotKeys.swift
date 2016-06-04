//
//  HotKeys.swift
//  keynav
//
//  Created by h2ero on 6/4/16.
//  Copyright © 2016 h2ero. All rights reserved.
//

import Cocoa
import Carbon

class HotKey {
    
    private let hotKey: UInt32
    private let block: (id:EventHotKeyID) -> ()
    private var registered = true
    
    private static var keyCodeHotKeys:[UInt32:EventHotKeyRef] = [:]
    
    typealias action = (id:EventHotKeyID) -> Void
    static var shortcuts = [UInt32:action]()
    
    private init(hotKeyID: UInt32, block: (id:EventHotKeyID) -> ()) {
        self.hotKey = hotKeyID
        self.block = block
        HotKey.shortcuts[hotKey] = block
    }
    
    static func registerHandler() {
        var eventHandler: EventHandlerRef = nil
        var eventType = EventTypeSpec(eventClass: OSType(kEventClassKeyboard), eventKind: UInt32(kEventHotKeyPressed))
        
        InstallEventHandler(GetApplicationEventTarget(), {(handlerRef: EventHandlerCallRef, eventRef: EventRef, ptr: UnsafeMutablePointer<Void>) -> OSStatus in
            var hotKeyID: EventHotKeyID = EventHotKeyID()
            
            GetEventParameter(eventRef, OSType(kEventParamDirectObject), EventParamType(typeEventHotKeyID), nil, sizeof(EventHotKeyID), nil, &hotKeyID)
            //call defined action based on hotKeyID
            HotKey.shortcuts[hotKeyID.id]!(id: hotKeyID)
            return noErr
            }, 1, &eventType, nil, &eventHandler) == noErr
    }
    
    private static var token: dispatch_once_t = 0
    
    class func register(keyCode: UInt32, modifiers: UInt32, block: (id:EventHotKeyID) -> (), id: UInt32) -> HotKey? {
        dispatch_once(&token) {
            HotKey.registerHandler()
        }
        var hotKey: EventHotKeyRef = nil
        let hotKeyID = EventHotKeyID(signature:OSType(10000), id: id)
        RegisterEventHotKey(keyCode, modifiers, hotKeyID, GetApplicationEventTarget(), OptionBits(0), &hotKey)
        HotKey.keyCodeHotKeys[keyCode] = hotKey
        return HotKey(hotKeyID: id, block: block)
    }
    
    func unregister(hotKey : EventHotKeyRef) {
        guard registered else {return}
        UnregisterEventHotKey(hotKey)
        // RemoveEventHandler(eventHandler)
        registered = false
    }
}
