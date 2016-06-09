//
//  HotKeys.swift
//  XEasyMotion
//
//  Created by h2ero on 6/4/16.
//  Copyright © 2016 h2ero. All rights reserved.
//

import Foundation
import Carbon

class HotKeys {
    private let hotKey: UInt32
    private let block: (id:EventHotKeyID) -> ()
    private static var eventHandler: EventHandlerRef = nil
    private static var keyCodeHotKeys:[UInt32:EventHotKeyRef] = [:]
    private static let signature:FourCharCode = UTGetOSTypeFromString("HotKeys")
    
    typealias action = (id:EventHotKeyID) -> Void
    private static var onceToken : dispatch_once_t = 0
    static var blocks = [UInt32:action]()
    
    private init(hotKeyID: UInt32, block: (id:EventHotKeyID) -> ()) {
        self.hotKey = hotKeyID
        self.block = block
        HotKeys.blocks[hotKey] = block
    }
    
    static func registerHandler() -> Bool {
        var eventHandler: EventHandlerRef = nil
        var eventType = EventTypeSpec(eventClass: OSType(kEventClassKeyboard), eventKind: UInt32(kEventHotKeyPressed))
        
        guard InstallEventHandler(GetApplicationEventTarget(), {(handlerRef: EventHandlerCallRef, eventRef: EventRef, ptr: UnsafeMutablePointer<Void>) -> OSStatus in
            var hotKeyID: EventHotKeyID = EventHotKeyID()
            let status = GetEventParameter(
                eventRef,
                EventParamName( kEventParamDirectObject ),
                EventParamType( typeEventHotKeyID ),
                nil,
                sizeof(EventHotKeyID),
                nil,
                &hotKeyID
            )
            
            if status != noErr || hotKeyID.signature != HotKeys.signature {
                return errSecBadReq
            }
            
            HotKeys.blocks[hotKeyID.id]!(id: hotKeyID)
                return noErr
            }, 1, &eventType, nil, &eventHandler) != noErr else {
                return false
        }
        HotKeys.eventHandler = eventHandler
        return  true
    }
    
    
    class func register(keyCode: UInt32, modifiers: UInt32, block: (id:EventHotKeyID) -> ()) -> HotKeys? {
        dispatch_once(&onceToken) {
            let status = HotKeys.registerHandler()
            Log.write(Log.ERROR, catelog: "registerHandler", value: String(status))
        }
        
        let id = keyCode + modifiers
        
        if HotKeys.isRegister(id) {
            return nil
        }
        var hotKey: EventHotKeyRef = nil
        let hotKeyID = EventHotKeyID(signature:HotKeys.signature, id: id)
        RegisterEventHotKey(keyCode, modifiers, hotKeyID, GetApplicationEventTarget(), OptionBits(0), &hotKey)
        HotKeys.keyCodeHotKeys[id] = hotKey
        return HotKeys(hotKeyID: id, block: block)
    }
    
    static func unregister(id:UInt32) {
        if HotKeys.isRegister(id) {
            UnregisterEventHotKey(HotKeys.keyCodeHotKeys[id]!)
            HotKeys.keyCodeHotKeys[id] = nil
        }
    }
    
    static func  unregisterAll()
    {
        for (keyCode, _) in HotKeys.keyCodeHotKeys {
            HotKeys.unregister(UInt32(keyCode))
        }
        // RemoveEventHandler(HotKeys.eventHandler)
    }
    
    static func isRegister(id:UInt32) -> Bool {
        return HotKeys.keyCodeHotKeys[id] != nil
    }
}
