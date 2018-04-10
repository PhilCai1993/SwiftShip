//
//  ITunesModels.swift
//  SwiftShip
//
//  Created by PhilCai on 2018/4/4.
//

import Foundation

struct Testflight {
  let appID: String
  let teamID: String
}

struct TestflightUsers : Codable {
  struct Internal : Codable {
    var id: String
    var providerId: Int
    var firstName: String
    var lastName: String
    var email: String
    var appAdamId: Int
  }
  var data: [Internal]
}

struct AppBuilds : Codable {
  struct Internal : Codable {
    var id: Int
    var bundleId: String
    var trainVersion: String
    var buildVersion: String
    var uploadDate: String
    var appAdamId: Int
    var providerId: Int
    var providerName: String
    var developerName: String
    var sizeInBytes: Int
    var internalExpireTime: String
    var externalExpireTime: String
    var platform: String
    var minOsVersion: String
    var iconAssetToken: String
    var inviteCount: Int
    var installCount: Int
    var activeTesterCount: Int
    var crashCount: Int
    var autoNotifyEnabled: Bool
    var didNotify: Bool
  }
  var data: [Internal]
}

struct AuthServiceResult : Codable {
  var authServiceKey: String
  var authServiceUrl: URL
}

struct Session : Codable {
  struct Provider : Codable {
    var providerId : Int
    var name : String
    var contentTypes: [String]
  }
  var availableProviders: [Provider]
}

struct FullData : Codable {
  
  struct Summary : Codable {
    struct Version : Codable {
      var type: String
      var platformString: String
      var everBeenOnSale: Bool
    }
    var adamId: String
    var bundleId: String
    var versionSets: [Version]
  }
  
  struct Internal : Codable {
    var summaries : [Summary]
  }
  
  var data: Internal
  var statusCode: String
}

struct UserDetail : Codable {
  
}

extension Testflight : CustomStringConvertible {
  var description: String {
    return "Testflight  AppID:\(appID)  TeamID:\(teamID)"
  }
}
