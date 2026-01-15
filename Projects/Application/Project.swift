import ProjectDescription

let project = Project(
    name: "Application",
    targets: [
        .target(
            name: "Application",
            destinations: .iOS,
            product: .framework,
            bundleId: "dev.tuist.Application",
            sources: ["Sources/**"],
            dependencies: [
                .project(target: "Domain", path: "../Domain")
            ]
        )
    ]
)
