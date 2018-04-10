//
//  Logger.swift
//  SwiftShip
//
//  Created by PhilCai on 2018/4/4.
//

import Foundation
import Rainbow

class Log {
  public class func info(_ msg: @autoclosure () -> String, functionName: String = #function,
                            lineNum: Int = #line, fileName: String = #file) {
    let content = "\n[" + fileName + " " + functionName + ":" + "LINE_" + "\(lineNum)" + "]" + msg()
    print(content.lightGreen)
  }
  
  public class func warning(_ msg: @autoclosure () -> String, functionName: String = #function,
                         lineNum: Int = #line, fileName: String = #file) {
    let content = "\n[" + fileName + " " + functionName + ":" + "LINE_" + "\(lineNum)" + "]" + msg()
    print(content.yellow)
  }
  
  public class func error(_ msg: @autoclosure () -> String, functionName: String = #function,
                            lineNum: Int = #line, fileName: String = #file) {
    let content = "\n[" + fileName + " " + functionName + ":" + "LINE_" + "\(lineNum)" + "]" + msg()
    print(content.red)
  }
}

func setupLogger() {
  
}
