//
//  File.swift
//  SwiftShip
//
//  Created by PhilCai on 2018/4/9.
//

import Foundation
import PromiseKit
import PMKFoundation


class HTTPManager {
  
  typealias Result = (data: Data, response: URLResponse)
  
  private let cookieStore = HTTPCookieStorage.shared
  
  private let urlSession: URLSession
  private (set) var isRequesting: Bool = false
  init() {
    let c = URLSessionConfiguration.default;
    c.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
    
    urlSession = URLSession(configuration: c)
    cookieStore.removeCookies(since: Date.distantPast)
  }
  func get(url: URL) -> Promise<Result> {
//    let semaphore = DispatchSemaphore(value: 0)
//    defer {
//      _ = semaphore.wait(timeout: .distantFuture)
//    }
    isRequesting = true
    let cookies = cookieStore.cookies ?? []
    let cookieHeader = HTTPCookie.requestHeaderFields(with: cookies)
    var request = URLRequest(url: url)
    
    request.httpShouldHandleCookies = true
    cookieHeader.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }
    return urlSession.dataTask(.promise, with: request).map { (data, response) -> Result in
      self.isRequesting = false
//      semaphore.signal()
      self.storeCookie(with: response, for: url)
      return (data, response)
    }
  }
  
  func get(request: URLRequest) -> Promise<Result> {
    isRequesting = true
    
//    let semaphore = DispatchSemaphore(value: 0)
//    defer {
//      _ = semaphore.wait(timeout: .distantFuture)
//    }
    let cookies = cookieStore.cookies ?? []
    let cookieHeader = HTTPCookie.requestHeaderFields(with: cookies)
    var req = request
    req.httpShouldHandleCookies = true
    cookieHeader.forEach { req.addValue($0.value, forHTTPHeaderField: $0.key) }
    return urlSession.dataTask(.promise, with: request).map { (data, response) -> Result in
//      semaphore.signal()
      self.isRequesting = false
      self.storeCookie(with: response, for: req.url!)
      return (data, response)
    }
  }
  
  
  func post(request: URLRequest) -> Promise<Result> {
    isRequesting = true
//    let semaphore = DispatchSemaphore(value: 0)
//    defer {
//      _ = semaphore.wait(timeout: .distantFuture)
//    }
    let cookies = cookieStore.cookies ?? []
    let cookieHeader = HTTPCookie.requestHeaderFields(with: cookies)
    var req = request
    req.httpMethod = "POST"
    req.httpShouldHandleCookies = false
    cookieHeader.forEach { req.addValue($0.value, forHTTPHeaderField: $0.key) }
    return urlSession.dataTask(.promise, with: request).map { (data, response) -> Result in
      self.isRequesting = false
//      semaphore.signal()
      self.storeCookie(with: response, for: req.url!)
      return (data, response)
    }
  }
  
  
  
  
  
  private func storeCookie(with response: URLResponse, for url: URL) {
    guard let resp = response as? HTTPURLResponse,
      let headers = resp.allHeaderFields as? [String:String]
      else {
        Log.warning("something wrong")
        return
    }
    
    let cookies = HTTPCookie.cookies(withResponseHeaderFields: headers, for: url)
    cookies.forEach { cookieStore.setCookie($0)}
  }
  
}
