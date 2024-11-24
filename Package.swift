// swift-tools-version:5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import class Foundation.ProcessInfo

let package = Package(
    name: "RevenueCat",
    defaultLocalization: "en",
    platforms: [
        .macOS(.v10_13),
        .watchOS("6.2"),
        .tvOS(.v11),
        .iOS(.v11)
    ],
    products: [
        .library(name: "RevenueCat",
                 targets: ["RevenueCat"]),
        .library(name: "RevenueCat_CustomEntitlementComputation",
                 targets: ["RevenueCat_CustomEntitlementComputation"]),
        .library(name: "ReceiptParser",
                 targets: ["ReceiptParser"]),
        .library(name: "RevenueCatUI",
                 targets: ["RevenueCatUI"])
    ],
    targets: [
        .target(name: "RevenueCat",
                path: "Sources",
                exclude: ["Info.plist", "LocalReceiptParsing/ReceiptParser-only-files"],
                resources: [
                    .copy("../Sources/PrivacyInfo.xcprivacy")
                ]),
        .target(name: "RevenueCat_CustomEntitlementComputation",
                path: "CustomEntitlementComputation",
                exclude: ["Info.plist", "LocalReceiptParsing/ReceiptParser-only-files"],
                resources: [
                    .copy("PrivacyInfo.xcprivacy")
                ],
                swiftSettings: [.define("ENABLE_CUSTOM_ENTITLEMENT_COMPUTATION")]),
        // Receipt Parser
        .target(name: "ReceiptParser",
                path: "LocalReceiptParsing"),
        // RevenueCatUI
        .target(name: "RevenueCatUI",
                dependencies: ["RevenueCat"],
                path: "RevenueCatUI",
                resources: [
                    .copy("Resources/background.jpg"),
                    .process("Resources/icons.xcassets")
                ]),
    ]
)