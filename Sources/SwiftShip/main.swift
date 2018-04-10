import PromiseKit
import Foundation
let iTunes = ITunesClient()

registDefaultActions()

repl()
RunLoop.main.run()


//
//func showHint () {
//  if !iTunes.loginSucceed {
//    Log.info("type \"login $YOUR_MAIL $YOUR_PASSWORD\" to login iTuneConnect")
//  } else {
//    Log.info("type \"testflight $YOUR_APPID\" to view Testflight")
//  }
//  Log.info("type \"quit\" to quit")
//}
//
//func act() throws {
//  let input = Console.getInput()
//  let command = getCommand(with: input)
//  Log.info("\(command)")
//  switch command {
//  case .quit:
//    exit(EXIT_SUCCESS)
//  case .login(let mail, let password):
//    let loginAndPrepare = firstly {
//      try iTunes.login(email: mail, password: password)
//      }.then {
//        return iTunes.prepare()
//    }
//    _ = loginAndPrepare.done {  (preparedData) -> Void  in
//      Log.info("prepared \n\(preparedData)")
//      try act()
//      }.catch({ (error) in
//        Log.error("error \(error)")
//        try? act()
//      })
//
//  case .testflight(let appID):
//    _ = try iTunes.getTestflight(appID: appID)
//      .done({ (testflight) in
//        Log.info("TF \n\(testflight)")
//      })
//  case .unknown(let reason):
//    Log.error(reason ?? "unknown")
//    showHint()
//    try act()
//  }
//}
//
//
//showHint()
//
//try act()
//RunLoop.main.run()
//
//
////
////let iTunes = ITunesClient()
////
////let prepare = firstly {
////  try iTunes.login(email: "xx@ele.me", password: "xxx")
////  }.then {
////    iTunes.prepare()
////}
////
////let logPrepare = prepare.then {  (preparedData) -> Promise<(FullData, Session, UserDetail)>  in
////  let (summaries, session, userDetail) = preparedData
////  Log.info("summaries \(summaries)")
////  Log.info("session \(session)")
////  Log.info("userDetail \(userDetail)")
////  return Promise.value((summaries, session,userDetail))
////}
////
////
////let getElemeAppTF = prepare.then { _ in
////  try iTunes.getTestflight(appID: "507161324")
////  }
////
////
////
//////  .catch { (err) in
//////    if let error = err as? ITunesClientError {
//////      switch error {
//////      case let .testflightError(errorDesc):
//////        Log.error(errorDesc)
//////        break
//////      case .loginError:
//////        Log.error("login fail")
//////        break
//////      }
//////    } else {
//////      Log.error(err.localizedDescription)
//////    }
//////
//////}
////
////getElemeAppTF.then { (testflight) in
//// return iTunes.getBuilds(testflight: testflight, appVersion: "7.36")
////  }.done { (build)  in
////    Log.info("\(build)")
////  }.catch { (err) in
////    Log.error("\(err)")
////}
////
//////getElemeAppTF.then { (testflight) in
//////  return iTunes.getInstalledTesters(testflight: testflight)
//////  }.done { (users)  in
//////
//////  }.catch { (err) in
//////
//////}
////
////RunLoop.main.run()
