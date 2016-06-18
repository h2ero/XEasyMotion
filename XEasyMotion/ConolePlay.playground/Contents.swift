import AppKit
import Foundation

final class AccessibilityElement {
    static let systemWideElement = AccessibilityElement.createSystemWideElement()
    
    var position: CGPoint? {
        get { return self.getPosition() }
        set {
            if let position = newValue {
                self.setPosition(position)
            }
        }
    }
    
    var size: CGSize? {
        get { return self.getSize() }
        set {
            if let size = newValue {
                self.setSize(size)
            }
        }
    }
    
    private let elementRef: AXUIElementRef
    
    init(elementRef: AXUIElementRef) {
        self.elementRef = elementRef
    }
    
    func elementAtPoint(point: CGPoint) -> Self? {
        var ref: AXUIElementRef?
        AXUIElementCopyElementAtPosition(self.elementRef, Float(point.x), Float(point.y), &ref)
        return ref.map(self.dynamicType.init)
    }
    
    func window() -> Self? {
        var element = self
        while element.role() != kAXWindowRole {
            if let nextElement = element.parent() {
                element = nextElement
            } else {
                return nil
            }
        }
        
        return element
    }
    
    func parent() -> Self? {
        return self.valueForAttribute(kAXParentAttribute)
    }
    
    func role() -> String? {
        return self.valueForAttribute(kAXRoleAttribute)
    }
    
    func pid() -> pid_t? {
        let pointer = UnsafeMutablePointer<pid_t>.alloc(1)
        let error = AXUIElementGetPid(self.elementRef, pointer)
        return error == .Success ? pointer.memory : nil
    }
    
    func bringToFront() {
        if let isMainWindow = self.rawValueForAttribute(NSAccessibilityMainAttribute) as? Bool
            where isMainWindow
        {
            return
        }
        
        AXUIElementSetAttributeValue(self.elementRef, NSAccessibilityMainAttribute, true)
    }
    
    // MARK: - Private functions
    
    static private func createSystemWideElement() -> Self {
        return self.init(elementRef: AXUIElementCreateSystemWide().takeUnretainedValue())
    }
    
    private func getPosition() -> CGPoint? {
        return self.valueForAttribute(kAXPositionAttribute)
    }
    
    private func setPosition(position: CGPoint) {
        if let value = AXValue.fromValue(position, type: .CGPoint) {
            AXUIElementSetAttributeValue(self.elementRef, kAXPositionAttribute, value)
        }
    }
    
    private func getSize() -> CGSize? {
        return self.valueForAttribute(kAXSizeAttribute)
    }
    
    
    private func setSize(size: CGSize) {
        if let value = AXValue.fromValue(size, type: .CGSize) {
            AXUIElementSetAttributeValue(self.elementRef, kAXSizeAttribute, value)
        }
    }
    
    private func rawValueForAttribute(attribute: String) -> AnyObject? {
        var rawValue: AnyObject?
        let error = AXUIElementCopyAttributeValue(self.elementRef, attribute, &rawValue)
        return error == .Success ? rawValue : nil
    }
    
    private func valueForAttribute(attribute: String) -> Self? {
        if let rawValue = self.rawValueForAttribute(attribute)
            where CFGetTypeID(rawValue) == AXUIElementGetTypeID()
        {
            return self.dynamicType.init(elementRef: rawValue as! AXUIElementRef)
        }
        
        return nil
    }
    
    private func valueForAttribute(attribute: String) -> String? {
        return self.rawValueForAttribute(attribute) as? String
    }
    
    private func valueForAttribute<T>(attribute: String) -> T? {
        if let rawValue = self.rawValueForAttribute(attribute)
            where CFGetTypeID(rawValue) == AXValueGetTypeID()
        {
            return (rawValue as! AXValue).toValue()
        }
        
        return nil
    }
    
    private func test() -> {
//        return self.valueForAttribute(kAXTitleAttribute)!
        return self.valueForAttribute(kAXTableRole)!

    }
}

extension AXValue {
    func toValue<T>() -> T? {
        let pointer = UnsafeMutablePointer<T>.alloc(1)
        let success = AXValueGetValue(self, AXValueGetType(self), pointer)
        return success ? pointer.memory : nil
    }
    
    static func fromValue<T>(value: T, type: AXValueType) -> AXValue? {
        let pointer = UnsafeMutablePointer<T>.alloc(1)
        pointer.memory = value
        return AXValueCreate(type, pointer)?.takeUnretainedValue()
        
    }
    
}

let point = CGPointMake(222, 333)
let acc = AccessibilityElement.createSystemWideElement()
let w = AccessibilityElement.systemWideElement.elementAtPoint(point)?.window()
print(w?.pid())
print(w!.getSize()?.height)
print(w!.test() as String)
