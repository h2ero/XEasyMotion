//
//  Constents.swift
//  keynav
//
//  Created by h2ero on 6/4/16.
//  Copyright © 2016 h2ero. All rights reserved.
//

import Foundation
import Carbon

class Constents {
    // mode: simple, hit_chars, orc
    static let modeSimple = "simple";
    static let modeHintChars = "hitChars";
    static let mode = Constents.modeSimple
    static let animation = false
    
    static let hintChars : [[String]] = [
        ["A","K","F"],
        ["H","S","L"],
        ["D","J",";"]
    ]
    
    static let hintCharsKeyCodeMap : [Int:String] = [
        kVK_ANSI_A          : "A",
        kVK_ANSI_F          : "F",
        kVK_ANSI_K          : "K",
        kVK_ANSI_S          : "S",
        kVK_ANSI_H          : "H",
        kVK_ANSI_L          : "L",
        kVK_ANSI_D          : "D",
        kVK_ANSI_J          : "J",
        kVK_ANSI_Semicolon  : ";"

    ]
    
    static let hitCharBaseFontSize:CGFloat = 40;
    static let hitCharMinFontSize:CGFloat = 12;
    
    static let  moveKeyCode :[String:Int] = [
        "UP"              : kVK_ANSI_K,
        "LEFT"            : kVK_ANSI_H,
        "RIGHT"           : kVK_ANSI_L,
        "DOWN"            : kVK_ANSI_J
    ]
    
}