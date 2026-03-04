import ProjectDescription

let project = Project(
    name: "Data",
    // 💡 1. 패키지를 어디서 다운받을지 주소(URL)를 명시해 줍니다.
    packages: [
        .remote(
            url: "https://github.com/socketio/socket.io-client-swift.git",
            requirement: .upToNextMajor(from: "16.0.0")
        ),
        .remote(
            url: "https://github.com/stasel/WebRTC.git",
            requirement: .upToNextMajor(from: "114.0.0")
        )
    ],
    targets: [
        .target(
            name: "Data",
            destinations: .iOS,
            product: .framework,
            bundleId: "dev.dan12.Data",
            deploymentTargets: .iOS("18.0"),
            sources: ["Sources/**"],
            dependencies: [
                .project(target: "Domain", path: "../Domain"),
                // 💡 2. 사용할 라이브러리들을 장착합니다.
                .package(product: "SocketIO"),
                .package(product: "WebRTC")
            ]
        )
    ]
)
