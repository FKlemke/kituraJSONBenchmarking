// swift-tools-version:3.1

import PackageDescription

let package = Package(
    name: "kituraJSONBenchmarking",
    dependencies: [
        .Package(url: "https://github.com/IBM-Swift/Kitura.git", majorVersion: 1, minor: 7),
        .Package(url: "https://github.com/IBM-Swift/SwiftyJSON.git", versions: Version(0,0,0)..<Version(50,0,0)),
        ]
)

