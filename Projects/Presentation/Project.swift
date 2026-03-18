import ProjectDescription

let project = Project(
    name: "Presentation",
    packages: [
        .remote(
            url: "https://github.com/shogo4405/HaishinKit.swift.git",
            requirement: .upToNextMajor(from: "1.9.0")
        ),
        .remote(
            url: "https://github.com/socketio/socket.io-client-swift.git",
            requirement: .upToNextMajor(from: "16.0.0")
        ),
        .remote(
            url: "https://github.com/stasel/WebRTC.git",
            requirement: .upToNextMajor(from: "114.0.0")
        ),
        .remote(
            url: "https://github.com/airbnb/lottie-ios.git",
            requirement: .upToNextMajor(from: "4.4.1")
        )
    ],
    targets: [
        Target.target(
            name: "Presentation",
            destinations: .iOS,
            product: .app,
            bundleId: "dev.dan12.Presentation",
            deploymentTargets: .iOS("18.0"),
            infoPlist: .extendingDefault(with: [
                "NSCameraUsageDescription": "방송을 위해 카메라 접근이 필요합니다.",
                "NSMicrophoneUsageDescription": "방송을 위해 마이크 접근이 필요합니다.",
                "NSLocalNetworkUsageDescription": "RTMP 서버 연결을 위해 로컬 네트워크 접근이 필요합니다.",
                "NSAppTransportSecurity": [
                    "NSAllowsArbitraryLoads": true
                ],
                "UIBackgroundModes": [
                    "audio"
                ],
                "UIApplicationSceneManifest": [
                    "UIApplicationSupportsMultipleScenes": false,
                    "UISceneConfigurations": [:]
                ],
                "UILaunchScreen": [
                    "UIColorName": "",
                    "UIImageName": ""
                ]
            ]),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [
                .package(product: "HaishinKit"),
                .package(product: "SocketIO"),
                .package(product: "WebRTC"),
                .package(product: "Lottie"),
                .project(target: "Domain", path: "../Domain"),
                .project(target: "Data", path: "../Data")
            ]
        )
    ]
)
