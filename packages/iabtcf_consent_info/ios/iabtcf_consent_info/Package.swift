// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "iabtcf_consent_info",
    platforms: [
        .iOS("12.0")
    ],
    products: [
        .library(name: "iabtcf-consent-info", targets: ["iabtcf_consent_info"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "iabtcf_consent_info"
        )
    ]
)
