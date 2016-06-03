//: Playground - noun: a place where people can play


//: [Previous](@previous)
import AppKit
import XCPlayground

class GradView: NSView{
    
    internal let hintChars : [[String]] = [
        ["a","f","k"],
        ["s","h","l"],
        ["d","j",";"]
    ]

    let hitCharSize:CGFloat = 18;
    
    override func drawRect(dirtyRect: NSRect)
    {
        // 设置透明
        NSColor.clearColor().set()
        NSRectFill(frame)
        
        let s = bounds.size
        NSLog(String(s.width))
        NSLog(String(s.height))
        let  rect = NSRect(x: 0.5 * s.width - 1, y: 0.5 * s.height - 1, width: 2, height: 2)
        let circlePath = NSBezierPath()
        circlePath.appendBezierPathWithRect(rect)
        circlePath.fill()
        drawGrad()
    }
    func drawGrad() {
        drawHorizLine(1/3.0)
        drawHorizLine(2/3.0)
        drawVertLie(1/3.0)
        drawVertLie(2/3.0)
        // draw chars
        let xAxis:[CGFloat] = [
            bounds.size.width / 6,
            bounds.size.width / 6 * 3,
            bounds.size.width / 6 * 5
        ]
        let yAxis:[CGFloat] = [
            bounds.size.height / 6,
            bounds.size.height / 6 * 3,
            bounds.size.height / 6 * 5
        ]
        
        for (x, row) in hintChars.enumerate(){
            for(y, hintChar) in row.enumerate(){
                drawChar(hintChar, x:  xAxis[x] - (hitCharSize/2), y: yAxis[y] - (hitCharSize / 2))
            }
        }
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
    
    func drawVertLie(frac:CGFloat){
        let y = frac * bounds.size.height
        drawLine(NSMakePoint(0, y),p2: NSMakePoint(bounds.size.width,y))
    }
    
    func drawChar(text:NSString,x:CGFloat, y:CGFloat)  {
        let p = NSMakePoint(x, y)
        let font = NSFont.systemFontOfSize(hitCharSize)
        let paraStyle = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        
        let attrs = [NSForegroundColorAttributeName: NSColor.blackColor(), NSFontAttributeName: font, NSParagraphStyleAttributeName: paraStyle]
        text.drawAtPoint(p, withAttributes: attrs)
    }
    
}

var vRect = NSRect(x: 0,y: 0,width: 500,height: 500)
var view = GradView(frame:vRect)
view.wantsLayer = true
view.layer?.backgroundColor = NSColor.windowBackgroundColor().CGColor
XCPlaygroundPage.currentPage.liveView = view