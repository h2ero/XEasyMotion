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
        if Constents.mode == Constents.modeHintChars {
            drawHorizLine(1/3.0)
            drawHorizLine(2/3.0)
            drawVertLine(1/3.0)
            drawVertLine(2/3.0)
        // draw chars
        let xAxis:[CGFloat] = [
            bounds.size.width / 6,
            bounds.size.width / 6 * 3,
            bounds.size.width / 6 * 5
        ]
        let yAxis:[CGFloat] = [
            bounds.size.height / 6 * 5,
            bounds.size.height / 6 * 3,
            bounds.size.height / 6
        ]
        
            for (y, row) in Constents.hintChars.enumerate(){
                for(x, hintChar) in row.enumerate(){
                    drawChar(hintChar, x:  xAxis[x] - (getHintCharFontSize()/2), y: yAxis[y] - (getHintCharFontSize() / 2))
                }
            }
        } else {
            
            drawHorizLine(0)
            drawHorizLine(1/2.0)
            drawHorizLine(1.0)
            
            drawVertLine(0)
            drawVertLine(1/2.0)
            drawVertLine(1.0)
        }
        drawPoint()
    }
    
    func drawLine(p1:CGPoint ,p2 :CGPoint){
        NSColor.redColor().set()
        NSBezierPath.setDefaultLineWidth(1.0)
        NSBezierPath.strokeLineFromPoint(p1, toPoint: p2)
    }
    
    func drawHorizLine(frac:CGFloat){
        let x = frac * bounds.size.width
        drawLine(NSMakePoint(x, 0),p2: NSMakePoint(x,bounds.size.height))
    }
    
    func drawVertLine(frac:CGFloat){
        let y = frac * bounds.size.height
        drawLine(NSMakePoint(0, y),p2: NSMakePoint(bounds.size.width,y))
    }
    
    func drawChar(text:NSString,x:CGFloat, y:CGFloat)  {
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
    func getHintCharFontSize() -> CGFloat {
        return max(Constents.hitCharBaseFontSize * bounds.size.width / 1000 , Constents.hitCharMinFontSize);
    }
    
}