// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RainConfetti",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "RainConfetti",
            targets: ["RainConfetti"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "RainConfetti",
            dependencies: [],
            path: "RainConfetti",
            exclude: ["DemoViewController.swift", "RainConfettiApp.swift", "ContentView.swift"],
            resources: [
                .copy("Assets/")
            ]
        ),
        .testTarget(
            name: "RainConfettiTests",
            dependencies: ["RainConfetti"],
            path: "Tests"
        ),
    ]
)