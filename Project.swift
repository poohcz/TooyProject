import ProjectDescription

let project = Project(
    name: "ToyProject",
    targets: [

        // MARK: - Domain
        .target(
            name: "Domain",
            destinations: .iOS,
            product: .framework,
            bundleId: "dev.tuist.domain",
            sources: ["Projects/Domain/**"]
        ),

        // MARK: - Data
        .target(
            name: "Data",
            destinations: .iOS,
            product: .framework,
            bundleId: "dev.tuist.data",
            sources: ["Projects/Data/**"],
            dependencies: [
                .target(name: "Domain")
            ]
        ),

        // MARK: - Application
        .target(
            name: "Application",
            destinations: .iOS,
            product: .framework,
            bundleId: "dev.tuist.application",
            sources: ["Projects/Application/**"],
            dependencies: [
                .target(name: "Domain")
            ]
        ),

        // MARK: - Presentation (App)
        .target(
            name: "Presentation",
            destinations: .iOS,
            product: .app,
            bundleId: "dev.tuist.presentation",
            infoPlist: .extendingDefault(with: [
                "UILaunchScreen": [:]
            ]),
            sources: ["Projects/Presentation/**"],
            dependencies: [
                .target(name: "Application")
            ]
        )
    ]
)
