//
//  Console.swift
//  SwiftShip
//
//  Created by PhilCai on 2018/4/9.
//

import Foundation


class Console {
  class func log(_ content: String) {
    Log.info(content)
  }
  class func getInput() -> String {
    let data = FileHandle.standardInput.availableData
    return String(data: data, encoding: .utf8)?.trimmingCharacters(in: .newlines) ?? ""
  }
}





func repl() {
  let input = Console.getInput()
  let task = getHandler(by: input)
  task(input) { repl() }
}



enum Command {
  case login(String, String)
  case testflight(String)
  case quit
  case unknown(String?)
  init(value: String) {
    let components = value.components(separatedBy: CharacterSet.whitespaces)
    guard let cmd = components.first else {
      self = .unknown("")
      return
    }
    switch cmd {
    case "login":
      if components.count != 3 {
        self = .unknown("invalid command for login, must provide mail and password")
      } else {
        self = .login(components[1],components[2])
      }
    case "testflight":
      if components.count != 2 {
        self = .unknown("invalid command for testflight, must provide app ID")
      } else {
        self = .testflight(components[1])
      }
    case "quit": self = .quit
    default: self = .unknown("invalid command name")
    }
  }
}

func getCommand(with input: String) -> Command {
  return Command(value: input)
}
