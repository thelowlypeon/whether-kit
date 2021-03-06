// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WhetherKit",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "WhetherKit",
            targets: ["WhetherKit"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/thelowlypeon/simple-networking.git", from: "0.0.4"),
        //.package(path: "../SimpleNetworking"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "WhetherKit",
            dependencies: ["SimpleNetworking"]),
        .testTarget(
            name: "WhetherKitTests",
            dependencies: ["WhetherKit"]),
    ]
)
