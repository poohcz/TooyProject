// Projects/App/Project.swift

import ProjectDescription

let project = Project(
    name: "App",
    targets: [
        .target(
            name: "App",
            destinations: .iOS,
            product: .app,
            bundleId: "dev.dan12.App",
            deploymentTargets: .iOS("18.0"),
            infoPlist: .extendingDefault(with: [
                "NSCameraUsageDescription": "방송을 위해 카메라 접근이 필요합니다.",
                "NSMicrophoneUsageDescription": "방송을 위해 마이크 접근이 필요합니다.",
                "NSLocalNetworkUsageDescription": "RTMP 서버 연결을 위해 로컬 네트워크 접근이 필요합니다.",
                "NSAppTransportSecurity": ["NSAllowsArbitraryLoads": true],
                "UIBackgroundModes": ["audio"],
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
            dependencies: [
                .project(target: "Presentation", path: "../Presentation")
            ]
        )
    ]
)
