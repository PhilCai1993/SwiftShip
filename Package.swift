// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "SwiftShip",
  dependencies: [
//    .package(url: "https://github.com/ReactiveX/RxSwift.git", "4.0.0" ..< "5.0.0"),
//    .package(url: "https://github.com/kylef/Commander", "0.8.0" ..< "1.0.0"),
//    .package(url: "https://github.com/IBM-Swift/LoggerAPI.git", .upToNextMinor(from: "1.7.0")),
//    .package(url: "https://github.com/IBM-Swift/HeliumLogger.git", from: "1.0.0"),
    .package(url: "https://github.com/mxcl/PromiseKit.git", from: "6.0.0"),
    .package(url: "https://github.com/PromiseKit/Foundation.git", from: "3.0.0"),
    .package(url: "https://github.com/onevcat/Rainbow", from: "3.0.0")
    ],
  targets: [
    .target(
      name: "SwiftShip",
      dependencies: [
//        "RxSwift",
//        "RxCocoa",
//        "Commander",
//        "HeliumLogger",
//        "LoggerAPI",
        "PromiseKit",
        "PMKFoundation",
        "Rainbow"
        
      ]),
    ]
)
