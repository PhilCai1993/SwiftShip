//
//  Actions.swift
//  SwiftShip
//
//  Created by PhilCai on 2018/4/11.
//

import Foundation
import PromiseKit

typealias Action = ()->()
typealias InputHandle = (String, @escaping Action)->()

var handlerMap: [String:InputHandle] = [:]

func login(input: String, completion: @escaping Action)  {
  let loginAndPrepare = firstly {
    try iTunes.login(email: input, password: "pass")
    }.then {
      return iTunes.prepare()
  }
  _ = loginAndPrepare.done {  (preparedData) -> Void  in
    Log.info("prepared \n\(preparedData)")
    completion()
    }.catch({ (error) in
      Log.error("error \(error)")
      completion()
    })
}

func handlerExample1(input: String, completion: @escaping Action)  {
  print("start handlerExample1")
  print("end handlerExample1")
  completion()
}

func handlerExample2(input: String, completion: @escaping Action)  {
  print("start handlerExample2")
  print("end handlerExample2")
  completion()
}

func registDefaultActions() {
  register(input: "a",
           handler: handlerExample1)
  register(input: "b",
           handler: handlerExample2)
  register(input: "login",
           handler: login)
}

func register(input: String, handler: @escaping InputHandle) {
  handlerMap[input] = handler
}

fileprivate func defaultHandler(input: String, completion: @escaping Action)  {
  print("default handler for \(input)")
  completion()
}


fileprivate func handle(input: String,
                        task: InputHandle,
                        completion: @escaping Action) {
  task(input) { completion() }
}

fileprivate func getHandler(by input: String) -> InputHandle {
  return handlerMap[input] ?? defaultHandler
}

