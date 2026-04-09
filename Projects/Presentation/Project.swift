// Projects/Presentation/Project.swift

import ProjectDescription

let project = Project(
    name: "Presentation",
    targets: [
        .target(
            name: "Presentation",
            destinations: .iOS,
            product: .framework,
            bundleId: "dev.dan12.Presentation",
            deploymentTargets: .iOS("18.0"),
            infoPlist: .default,
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [
                .project(target: "Domain", path: "../Domain"),
                .project(target: "Data", path: "../Data"),
                .external(name: "HaishinKit"),
                .external(name: "SocketIO"),
                .external(name: "WebRTC"),
                .external(name: "Lottie")
            ]
        )
    ]
)
