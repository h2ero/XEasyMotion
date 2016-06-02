//: Playground - noun: a place where people can play


//: [Previous](@previous)
import AppKit
import XCPlayground

class GradView: NSView{
    override func drawRect(dirtyRect: NSRect)
    {
        NSColor.clearColor().set()
        NSRectFill(frame)
        NSColor.greenColor().setFill()
        let s = bounds.size
        let  rect = NSMakeRect(0.5 * s.width - 1, 0.5 * s.height - 1, 2, 2);
        let circlePath = NSBezierPath()
        circlePath.appendBezierPathWithOvalInRect(rect)
        circlePath.fill()
        
        drawHorizLine(1/3.0)
        drawHorizLine(2/3.0)
        drawVertLie(1/3.0)
        drawVertLie(2/3.0)
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
}

var vRect = NSRect(x: 0,y: 0,width: 500,height: 500)
var view = GradView(frame:vRect)
view.wantsLayer = true
view.layer?.backgroundColor = NSColor.windowBackgroundColor().CGColor
XCPlaygroundPage.currentPage.liveView = view