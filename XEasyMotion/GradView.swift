//
//  GradView.swift
//  keynav
//
//  Created by h2ero on 5/27/16.
//  Copyright © 2016 h2ero. All rights reserved.
//

import Cocoa
import Foundation
class GradView: NSView{
    
      
    override func draw(_ dirtyRect: NSRect)
    {
        // 设置透明
//        NSColor.clearColor().set()
        drawGrad()
    }
    func drawPoint(){
        let s = bounds.size
        let rect = NSMakeRect(0.5 * s.width - 2.5, 0.5 * s.height - 2.5, 5, 5);
        let circlePath = NSBezierPath()
        circlePath.appendOval(in: rect)
        NSColor.gray.setFill()
        circlePath.fill()
    }
    
    func drawGrad() {
        if Config.getEnableMode() == Constents.nineBlockMode {
            NineBlockMode.draw()
        } else {
            SimpleMode.draw()
        }
        drawPoint()
    }
    
    static func drawLine(p1:CGPoint ,p2 :CGPoint){
        NSColor.red.set()
        NSBezierPath.defaultLineWidth = 1.0
        NSBezierPath.strokeLine(from: p1, to: p2)
    }
    
    static func drawHorizLine(frac:CGFloat){
        let x = frac * getSize().width
        drawLine(p1: NSMakePoint(x, 0),p2: NSMakePoint(x,getSize().height))
    }
    
    static func drawVertLine(frac:CGFloat){
        let y = frac * getSize().height
        drawLine(p1: NSMakePoint(0, y),p2: NSMakePoint(getSize().width,y))
    }
    
    static func drawChar(text:NSString,x:CGFloat, y:CGFloat)  {
        let p = NSMakePoint(x, y)
        let font = NSFont.systemFont(ofSize: getHintCharFontSize())
        let paraStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        let fontColor = NSColor.green
        
        let attrs = [
            NSAttributedStringKey.font: font,
            NSAttributedStringKey.paragraphStyle: paraStyle,
            NSAttributedStringKey.foregroundColor: fontColor
        ]
        text.draw(at: p, withAttributes: attrs)
    }
    static func getHintCharFontSize() -> CGFloat {
        return max(Constents.hitCharBaseFontSize * self.getSize().width / 1000 , Constents.hitCharMinFontSize);
    }
    
    static func getSize() -> CGSize {
        let windowFirst = Util.getWindowFirst()
        return windowFirst.frame.size
    }
    
}
