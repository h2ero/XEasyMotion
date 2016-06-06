//: Playground - noun: a place where people can play

import Cocoa

class Util {
    static let hintChars : [[String]] = [
    ["A","K","F"],
    ["H","S","L"],
    ["D","J",";"]
    ]
static func getPostion(hintChar:String, startX :CGFloat, startY:CGFloat, width:CGFloat, height:CGFloat) {
    let xStep = width / 3
    let yStep = height / 3
    
    var x : Int = 0;
    var y : Int = 0;
    breakLabel : for (index, row)  in Util.hintChars.enumerate(){
        for(subIndex,checkHintChar) in row.enumerate(){
            if hintChar == checkHintChar {
                x = subIndex;
                y = index;
                break breakLabel;
//                print(checkHintChar,CGFloat(x) * xStep , (-CGFloat(y) * yStep) + height - yStep)
            }
        }
    }
    
    print(CGFloat(x) * xStep , (-CGFloat(y) * yStep) + height - yStep)
    
//    var topIndex = 0
//    var index = 0
//    while y >= startY  {
//        while  x <= startX + xStep * 2{
//            print(x,y)
//            x = x + xStep
//        }
//        x = startX
//        y = y - yStep
//    }
}
}

//Util.getPostion("K", startX: 0, startY: 0, width: 300, height: 300)
//Util.getPostion("K", startX: 0, startY: 0, width: 3, height: 3)
