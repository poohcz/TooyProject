// swift-tools-version: 6.0
import PackageDescription

#if TUIST
    import struct ProjectDescription.PackageSettings

    let packageSettings = PackageSettings(
        productTypes: [
            "HaishinKit": .framework,
            "WebRTC": .framework,
            "SocketIO": .framework,
            "Lottie": .framework
        ]
    )
#endif

let package = Package(
    name: "ToyProject",
    dependencies: [
        .package(url: "https://github.com/shogo4405/HaishinKit.swift.git", from: "1.9.0"),
        .package(url: "https://github.com/socketio/socket.io-client-swift.git", from: "16.0.0"),
        .package(url: "https://github.com/stasel/WebRTC.git", from: "114.0.0"),
        .package(url: "https://github.com/airbnb/lottie-ios.git", from: "4.4.1")
    ]
)
