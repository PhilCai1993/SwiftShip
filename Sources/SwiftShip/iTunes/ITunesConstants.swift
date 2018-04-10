//
//  ITunesConstants.swift
//  SwiftShip
//
//  Created by PhilCai on 2018/4/3.
//

import Foundation

let kServiceURL = URL(string: "https://olympus.itunes.apple.com/v1/app/config?hostname=itunesconnect.apple.com")!
let kLoginURL = URL(string: "https://idmsa.apple.com/appleauth/auth/signin")!

let KUserDetailURL = URL(string: "https://itunesconnect.apple.com/WebObjects/iTunesConnect.woa/ra/user/detail")!
let KAppsURL = URL(string: "https://itunesconnect.apple.com/WebObjects/iTunesConnect.woa/ra/apps/manageyourapps/summary/v2")!
let kSessionURL = URL(string: "https://itunesconnect.apple.com/olympus/v1/session")!

func installedTestersURL(teamID: String, appID: String) -> URL {
  return URL(string: "https://itunesconnect.apple.com/testflight/v2/providers/\(teamID)/apps/\(appID)/testers?order=dsc&sort=status")!
}

func getBuildsURL(teamID: String, appID: String, version: String)  -> URL {
  return URL(string: "https://itunesconnect.apple.com/testflight/v2/providers/\(teamID)/apps/\(appID)/platforms/ios/trains/\(version)/builds")!
}

