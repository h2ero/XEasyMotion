
//  Mode.swift
//  XEasyMotion
//
//  Created by h2ero on 6/19/16.
//  Copyright © 2016 h2ero. All rights reserved.
//

import Foundation

protocol Mode {
    static func draw()
    static func moveWindow()
    static func resizeWindow()
    static func addMoveKeyBind()
    static func addResizeKeyBind()
}