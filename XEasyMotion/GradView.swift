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
    
      
    override func drawRect(dirtyRect: NSRect)
    {
        // 设置透明
//        NSColor.clearColor().set()
        drawGrad()
    }
    func drawPoint(){
        let s = bounds.size
        let rect = NSMakeRect(0.5 * s.width - 1, 0.5 * s.height - 1, 5, 5);
        let circlePath = NSBezierPath()
        circlePath.appendBezierPathWithOvalInRect(rect)
        NSColor.grayColor().setFill()
        circlePath.fill()
    }
    
    func drawGrad() {
        if Constents.mode == Constents.nineBlockMode {
            NineBlockMode.draw()
        } else {
            SimpleMode.draw()
        }
        drawPoint()
    }
    
    static func drawLine(p1:CGPoint ,p2 :CGPoint){
        NSColor.redColor().set()
        NSBezierPath.setDefaultLineWidth(1.0)
        NSBezierPath.strokeLineFromPoint(p1, toPoint: p2)
    }
    
    static func drawHorizLine(frac:CGFloat){
        let x = frac * getSize().width
        drawLine(NSMakePoint(x, 0),p2: NSMakePoint(x,getSize().height))
    }
    
    static func drawVertLine(frac:CGFloat){
        let y = frac * getSize().height
        drawLine(NSMakePoint(0, y),p2: NSMakePoint(getSize().width,y))
    }
    
    static func drawChar(text:NSString,x:CGFloat, y:CGFloat)  {
        let p = NSMakePoint(x, y)
        let font = NSFont.systemFontOfSize(getHintCharFontSize())
        let paraStyle = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        let fontColor = NSColor.greenColor()
        
        let attrs = [
            NSFontAttributeName: font,
            NSParagraphStyleAttributeName: paraStyle,
            NSForegroundColorAttributeName: fontColor
        ]
        text.drawAtPoint(p, withAttributes: attrs)
    }
    static func getHintCharFontSize() -> CGFloat {
        return max(Constents.hitCharBaseFontSize * self.getSize().width / 1000 , Constents.hitCharMinFontSize);
    }
    
    static func getSize() -> CGSize {
        let windowFirst = Util.getWindowFirst()
        return windowFirst.frame.size
    }
    
}