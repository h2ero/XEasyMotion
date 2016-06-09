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
    private static var keycodeHotKeys:[UInt32:EventHotKeyRef] = [:]
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
    
    
    class func register(keycode: UInt32, modifiers: UInt32, block: (id:EventHotKeyID) -> ()) -> HotKeys? {
        dispatch_once(&onceToken) {
            let status = HotKeys.registerHandler()
            Log.write(Log.ERROR, catelog: "registerHandler", value: String(status))
        }
        
        let id:UInt32 = keycode + modifiers
        
        if HotKeys.isRegister(id) {
            return nil
        }
        
        Log.write(Log.INFO, catelog: "register key", value: HotKeys.transKeycodeToStr(UInt16(keycode)) + "-" + String(id))
        
        var hotKey: EventHotKeyRef = nil
        let hotKeyID = EventHotKeyID(signature:HotKeys.signature, id: id)
        RegisterEventHotKey(keycode, modifiers, hotKeyID, GetApplicationEventTarget(), OptionBits(0), &hotKey)
        HotKeys.keycodeHotKeys[id] = hotKey
        return HotKeys(hotKeyID: id, block: block)
    }
    
    static func unregister(id:UInt32) {
            Log.write(Log.INFO, catelog: "unregister key", value: String(transKeycodeToStr(UInt16(id))))
        if HotKeys.isRegister(id) {
            Log.write(Log.INFO, catelog: "unregister key", value: String(transKeycodeToStr(UInt16(id))))
            UnregisterEventHotKey(HotKeys.keycodeHotKeys[id]!)
            HotKeys.keycodeHotKeys[id] = nil
        }
    }
    
    static func  unregisterAll()
    {
        for (keycode, _) in HotKeys.keycodeHotKeys {
            HotKeys.unregister(UInt32(keycode))
        }
        // RemoveEventHandler(HotKeys.eventHandler)
    }
    
    static func isRegister(id:UInt32) -> Bool {
        return HotKeys.keycodeHotKeys[id] != nil
    }
    static func transKeycodeToStr( keyCode:UInt16 ) -> String {
        
        // Everything else should be printable so look it up in the current ASCII capable keyboard layout
        var error = noErr
        
        var keystroke:NSString? = nil
        
        let inputSource:TISInputSource!
            = TISCopyCurrentASCIICapableKeyboardLayoutInputSource().takeUnretainedValue()
        
        if inputSource == nil {
            return keystroke as! String
        }
        
        let layoutDataRef_ptr = TISGetInputSourceProperty( inputSource, kTISPropertyUnicodeKeyLayoutData)
        let layoutDataRef:CFDataRef! = unsafeBitCast( layoutDataRef_ptr, CFDataRef.self )
        
        if layoutDataRef == nil {
            return keystroke as! String
        }
        
        let layoutData
            = unsafeBitCast( CFDataGetBytePtr(layoutDataRef), UnsafePointer<CoreServices.UCKeyboardLayout>.self )
        
        let key_translate_options = OptionBits(CoreServices.kUCKeyTranslateNoDeadKeysBit)
        var deadKeyState = UInt32( 0 )
        let max_chars = 256
        var chars = [UniChar]( count:max_chars, repeatedValue:0 )
        var length = 0
        
        error = CoreServices.UCKeyTranslate(
            layoutData,
            keyCode,
            UInt16( CoreServices.kUCKeyActionDisplay ),
            UInt32( 0 ), // No modifiers
            UInt32( LMGetKbdType() ),
            key_translate_options,
            &deadKeyState,
            max_chars,
            &length,
            &chars
        )
        
        keystroke
            = ( error == noErr ) && ( length > 0 )
            ? NSString( characters:&chars, length:length )
            : ""
        
        return keystroke as! String
        
        
    }
    
}
