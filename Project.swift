import ProjectDescription

let project = Project(
    name: "ToyProject",
    targets: [
        // MARK: - Domain
        .target(
            name: "Domain",
            destinations: .iOS,
            product: .framework,
            bundleId: "dev.tuist.Domain",
            sources: ["Sources/Domain/**"]
        ),

        // MARK: - Data
        .target(
            name: "Data",
            destinations: .iOS,
            product: .framework,
            bundleId: "dev.tuist.Data",
            sources: ["Sources/Data/**"],
            dependencies: [
                .target(name: "Domain")
            ]
        ),

        // MARK: - Presentation
        .target(
            name: "Presentation",
            destinations: .iOS,
            product: .app,
            bundleId: "dev.tuist.Presentation",
            infoPlist: .extendingDefault(with: [
                "UILaunchScreen": [:]
            ]),
            sources: ["Sources/Presentation/**"],
            dependencies: [
                .target(name: "Domain"),
                .target(name: "Data")
            ]
        ),

        // MARK: - Tests
        .target(
            name: "PresentationTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "dev.tuist.PresentationTests",
            sources: ["Sources/Tests/**"],
            dependencies: [
                .target(name: "Presentation")
            ]
        )
    ]
)
