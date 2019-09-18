// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UserDefaultsGenerator",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .executable(name: "udg", targets: ["UserDefaultsGenerator"]),
        .library(
            name: "UserDefaultsGeneratorCore",
            targets: ["UserDefaultsGeneratorCore"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
      .package(url: "https://github.com/jpsim/Yams.git", from: Version(2, 0, 0)),

    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "UserDefaultsGenerator",
            dependencies: ["UserDefaultsGeneratorCore"]),
        .target(
            name: "UserDefaultsGeneratorCore",
            dependencies: ["Yams"]),
        .target(
            name: "UserDefaultsGenerator",
            dependencies: []),
        .testTarget(
            name: "UserDefaultsGeneratorTests",
            dependencies: ["UserDefaultsGenerator"]),
    ]
)
