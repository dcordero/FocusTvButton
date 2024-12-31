// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "FocusTvButton",
    platforms: [
        .tvOS(.v10)
    ],
    products: [
        .library(
            name: "FocusTvButton",
            targets: ["FocusTvButton"])
    ],
    dependencies: [
        .package(url: "https://github.com/uber/ios-snapshot-test-case.git",
                 from: "7.0.0")
    ],
    targets: [
        .target(
            name: "FocusTvButton",
            dependencies: [],
            path: "FocusTvButton/Source"
        ),
        .testTarget(
            name: "FocusTvButtonTests",
            dependencies: ["FocusTvButton",
                           .product(name: "FBSnapshotTestCase",
                                    package: "ios-snapshot-test-case")
            ],
            path: "FocusTvButton/FocusTvButtonTests"
        )
    ]
)
