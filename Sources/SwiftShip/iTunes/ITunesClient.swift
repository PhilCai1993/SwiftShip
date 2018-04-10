//
//  ITunesClient.swift
//  SwiftShip
//
//  Created by PhilCai on 2018/4/3.
//

import Foundation


import PromiseKit
import PMKFoundation

public enum ITunesClientError : Swift.Error {
  case loginError
  case testflightError(String)
}

class ITunesClient {
  private let httpManager = HTTPManager()
  private var preparation: (FullData, Session, UserDetail)?
  var isRequesting: Bool {
    return httpManager.isRequesting
  }
  
  var loginSucceed: Bool {
    return self.preparation != nil
  }
  
  /// 0.登录
  ///
  /// - Parameters:
  ///   - email: 邮箱
  ///   - password: 密码
  func login(email: String, password: String) throws -> Promise<Void> {
    let buildRequest = getAuthServiceKey().map { auth -> URLRequest in
      let JSON: [String: Any] = ["accountName": email, "password": password, "rememberMe": true]
      let JSONData = try! JSONSerialization.data(withJSONObject: JSON, options: JSONSerialization.WritingOptions.prettyPrinted)
      let JSONString = String(data: JSONData, encoding: .utf8)!
      let body = JSONString.data(using: .utf8)!
      var request = URLRequest(url: kLoginURL)
      let headers = [ "X-Apple-Domain-Id": "1",
                      "X-Requested-With": "XMLHttpRequest",
                      "X-Apple-Widget-Key": auth,
                      "Content-Type":"application/json","Accept":"application/json, text/javascript" ]
      request.httpMethod = "post"
      request.httpBody = body
      request.allHTTPHeaderFields = headers
      return request
    }
    return buildRequest.then { request in
      
      self.httpManager.post(request: request).map { (data, resp) -> Void in
        guard let response = resp as? HTTPURLResponse else {
          throw ITunesClientError.loginError
        }
        if response.statusCode != 200 {
          throw ITunesClientError.loginError
        } else {
          Log.info("Login successfully.")
        }
      }
    }
  }
  
  /// 1. 获取基本信息
  func prepare() -> Promise<(FullData, Session, UserDetail)> {
    Log.info("Prepare for necessary information")
    return when(fulfilled: getSummaries(), getSession(), getUserDetail()).then {  (preparedData) -> Promise<(FullData, Session, UserDetail)>  in
      let (summaries, session, userDetail) = preparedData
      self.preparation = preparedData
      Log.info("Get necessary information successfully")
      return Promise.value((summaries, session,userDetail))
    }
  }
  
  /// 2. 生成Testflight
  func getTestflight(appID: String) throws -> Promise<Testflight> {
    guard let preparation = self.preparation else {
      throw ITunesClientError.testflightError("must call prepare() first")
    }
    let summaries = preparation.0.data.summaries
    let providers = preparation.1.availableProviders
    let summary = summaries.filter { $0.adamId == appID }.first
    guard summary != nil else {
      throw ITunesClientError.testflightError("App with ID '\(appID)' does not exist ")
    }
    guard let provider = providers.first else {
      throw ITunesClientError.testflightError("Providers unavailable")
    }
    let testflight = Testflight(appID: appID, teamID: String(provider.providerId))
    return Promise.value(testflight)
  }
  
  func getInstalledTesters(testflight: Testflight) -> Promise<TestflightUsers> {
    return httpManager.get(url: installedTestersURL(teamID: testflight.teamID, appID: testflight.appID))
                      .map { try JSONDecoder().decode(TestflightUsers.self, from: $0.data) }
  }
  
  func getBuilds(testflight: Testflight, appVersion: String) -> Promise<[AppBuilds.Internal]> {
//    return httpManager.get(url: getBuildsURL(teamID: testflight.teamID, appID: testflight.appID, version: appVersion))
//      .map { try JSONDecoder().decode(AppBuilds.self, from: $0.data).data.sorted(by: {a,b in
//        return a.buildVersion.compare(b.buildVersion) == ComparisonResult.orderedDescending
//      })}
    return httpManager.get(url: getBuildsURL(teamID: testflight.teamID, appID: testflight.appID, version: appVersion))
      .map { try JSONDecoder().decode(AppBuilds.self, from: $0.data).data
                              .sorted(by: {$0.buildVersion.compare($1.buildVersion) == .orderedDescending })}
  }
  
  
  
  private func getAuthServiceKey() -> Promise<String> {
    return httpManager.get(url: kServiceURL)
                      .map { try JSONDecoder().decode(AuthServiceResult.self, from: $0.data).authServiceKey }
  }
  
  private func getSession() -> Promise<Session>{
    return httpManager.get(url: kSessionURL)
                      .map { try JSONDecoder().decode(Session.self, from: $0.data) }
  }
  
  private func getSummaries() -> Promise<FullData> {
    return httpManager.get(url: KAppsURL)
                      .map { try JSONDecoder().decode(FullData.self, from: $0.data) }
  }
  
  private func getUserDetail() -> Promise<UserDetail> {
    return httpManager.get(url: KUserDetailURL)
                      .map { try JSONDecoder().decode(UserDetail.self, from: $0.data) }
  }
  
}
